"""Methods here only handle single task.
This file leverages functions in core.py.
"""

import copy
import json
import os
import re
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
from io import BytesIO
from itertools import chain, repeat
from typing import List, Optional, Union
from zipfile import ZipFile

import cv2
import httpx
import numpy as np
from more_itertools import consume

from data_tools.cvat.core import Core


def flatten_dict(d, parent_key="", sep=".") -> dict:
    # AI generated
    items = []
    for key, value in d.items():
        new_key = f"{parent_key}{sep}{key}" if parent_key else key
        if isinstance(value, dict):
            items.extend(flatten_dict(value, new_key, sep).items())
        else:
            items.append((new_key, str(value)))
    return dict(items)


def format_detail(data, _type) -> str:
    # AI generated
    flattened_data = flatten_dict(data)
    flattened_data.pop("id", None)

    max_key_len = max(len(key) for key in flattened_data.keys())
    max_value_len = max(len(str(value)) for value in flattened_data.values())

    s = f"{_type}: {data['id']}"
    s += "\n" + "-" * max_key_len + "-+-" + "-" * max_value_len
    for key, value in flattened_data.items():
        s += f"\n{key:<{max_key_len}} | {value:<{max_value_len}}"
    s += "\n" + "-" * max_key_len + "-+-" + "-" * max_value_len
    return s


def natural_sort_key(s, _nsre=re.compile("([0-9]+)")) -> list:
    """Key function for natural sort.
    Do
    1 20 10 100 -> 1 10 20 100
    not
    1 20 10 100 -> 1 10 100 20
    """
    return [int(text) if text.isdigit() else text.lower() for text in _nsre.split(s)]


def modified(json_obj: dict, interval: int) -> bool:
    """Check if a task is modifed in the given interval of days.

    Args:
        json_obj (dict): A json object that stores one tasks's information.
        interval (int): Number of days.

    Returns:
        bool
    """
    if not interval:
        return True
    updated_t = datetime.strptime(json_obj["updated_date"], "%Y-%m-%dT%H:%M:%S.%fZ")
    today = datetime.now()
    diff = (today - updated_t).days
    return diff <= interval


class SingleOps(Core):
    """CVAT Client that operates on single task/project/image chunk.
    Methods here are designed for concurrent usage.
    """

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def obj_print(
        self,
        obj: dict,
        _type: str,
        interval: int,
        use_json_output: bool,
    ):
        if not modified(obj, interval):
            return
        if use_json_output:
            return self.log.info(json.dumps(obj, indent=2))
        map = dict(
            Job=lambda obj: f"Job: {obj.get('id'):>3d} (Task: {obj.get('task_id')}), {obj.get('frame_count'):>3d} Frames",
            Task=lambda obj: f"Task: {obj.get('id'):>5d} (Project: {str(obj.get('project_id')):>4s}), {obj.get('name')}",
            Project=lambda obj: f"Project: {obj.get('id'):>3d} ({obj.get('tasks').get('count'):>3d} tasks) {obj.get('name')}",
        )
        self.log.info(map[_type](obj))

    def detail(
        self,
        _id: int,
        _type: str,
        labels_only: bool = False,
        use_json_output: bool = False,
    ) -> None:
        json_obj = self.check_existence(_id, _type)
        if not json_obj:
            return

        if _type != "Project":
            anno_type_count = self.statistics(_id, _type)

            stats = ", ".join(
                [f"{k.capitalize()}s: {v}" for k, v in sorted(anno_type_count.items(), key=lambda x: x[0])]
            )
            json_obj["Labels"] = stats
            if labels_only:
                json_obj = dict(id=json_obj["id"], Labels=stats)

        if use_json_output:
            return print(json.dumps(json_obj, indent=2))
        self.log.info(format_detail(json_obj, _type))

    def check_existence(self, _id: int, _type: str) -> Optional[dict]:
        json_obj = self.info(_id, _type)
        if not json_obj:
            return self.log.warning(f"{_type} {_id:>5d}, Not Found")
        return json_obj

    def download_image_chunk(
        self,
        task_id: int,
        dir: str,
    ) -> None:
        """Download single image chunk from a task."""

        info = self.check_existence(task_id, _type="Task")
        if not info:
            return
        if info["data_compressed_chunk_type"] != "imageset":
            return self.log.warning(f"Task {task_id} dones't support chunked images.")

        dir = os.path.join(dir, info.get("name"))
        os.makedirs(dir, exist_ok=True)

        chunk_size = info.get("data_chunk_size")
        total_size = info.get("size")
        num_chunk, rest = divmod(total_size, chunk_size)
        num_chunk += (rest != 0) * 1

        # Need this to get the frame step
        frame_step = self.meta(task_id, "Task").get("frame_filter")
        frame_step = frame_step.replace("step=", "")
        frame_step = 1 if frame_step == "" else int(frame_step)

        def download(task_id, chunk_id):
            chunk = self.chunk_images(task_id, chunk_id)
            with ZipFile(BytesIO(chunk)) as z:
                for name in z.namelist():
                    name_num, _ = name.split(".")
                    name_num = chunk_id * chunk_size + int(name_num)
                    fname = f"frame_{name_num * frame_step:06d}.jpg"
                    outfile = os.path.join(dir, fname)
                    with open(outfile, "wb") as f:
                        f.write(z.read(name))

        msg = f"Task {task_id:>5d}, Download chunk {', '.join(map(str, range(num_chunk)))}"
        self.log.info(f"{msg} start.")
        with ThreadPoolExecutor() as executor:
            futures = [executor.submit(download, task_id, chunk_id) for chunk_id in range(num_chunk)]
            for fut in as_completed(futures):
                fut.result()
        self.log.info(f"{msg} done.")

    def auto_label(
        self,
        task_id: int,
        chunk_id: int,
        chunk_size: int,
        task_annotation: dict,
        model,  # nn.Module, here is intentionally left not typed
        name_map: dict,
        input_size: int,
        normalized: bool,
        score_threshold: float,
        roi: List[float],
        denormalized_roi: List[float],
    ) -> None:
        """Inferece single image chunk of a task. This method is design for
        multi-threading. Please referes to Client.concurrent_autolabel for the
        usage.
        """

        from data_tools.cvat.utils.cvat_objs import SHAPE

        # *** For Gogoro only ***
        # this is a temporary import, util we finish the gogoro project
        # from data_tools.cvat.utils.getters import temp_ggr_od_inference
        # ***********************
        # *** Inference pipeline ***
        from data_tools.cvat.utils.getters import od_inference

        # **************************
        self.log.info(f"Task: {task_id}, Chunk: {chunk_id}, Start")

        class_names = list(name_map.keys())

        chunk = self.chunk_images(task_id, chunk_id)

        with ZipFile(BytesIO(chunk)) as z:
            for name in z.namelist():
                image = cv2.imdecode(np.frombuffer(z.read(name), np.uint8), 1)

                # TODO: (mike) More config control here.
                # *** For Gogoro Only ***
                # outputs = temp_ggr_od_inference(image, model, input_size).detach().cpu()
                # offset = 0
                # ***********************

                # *** Inference Pipeline ***
                outputs = od_inference(image, model, roi, input_size, normalized)
                offset = 1
                # **************************

                name_num, _ = name.split(".")
                name_num = chunk_id * chunk_size + int(name_num)
                for output in outputs:
                    class_name = class_names[int(output[-1]) - offset]
                    class_data = name_map.get(class_name)
                    if not class_data or (output[-2] < score_threshold):
                        continue
                    shape_obj = copy.copy(SHAPE)
                    shape_obj["label_id"] = class_data.get("label_id")
                    shape_obj["frame"] = name_num
                    shape_obj["points"] = list(map(float, output[:4]))
                    shape_obj["attributes"] = class_data.get("attributes")
                    task_annotation["shapes"].append(shape_obj)

        self.log.info(f"Task: {task_id}, Chunk: {chunk_id}, Done")

    def upload(self, task_id: int, file: str, override: bool) -> None:
        """Upload annotation.

        This method only accepts the annotation file from dump.
        """
        info = self.check_existence(task_id, "Task")
        if not info:
            return

        labels = [label for labels in self.label_iter(task_id, "Task") for label in labels]

        # TODO (mike): Threads
        # name to new id
        name2id = {}
        for label in labels:
            name = label["name"]
            name2id[name] = {"id": label["id"], "spec": {}}
            attrs = label.get("attributes")
            for attr in attrs:
                attr_name = attr["name"]
                name2id[name]["spec"][attr_name] = attr["id"]

        # update label_id and spec_id
        with open(file, "r") as f:
            data = json.load(f)
        for key in ("tags", "shapes", "tracks"):
            for ele in data[key]:
                if key == "tracks":
                    for shape in ele["shapes"]:
                        for attr in shape["attributes"]:
                            attr["spec_id"] = name2id[ele["label_id"]]["spec"][attr["spec_id"]]
                for attr in ele["attributes"]:
                    attr["spec_id"] = name2id[ele["label_id"]]["spec"][attr["spec_id"]]
                ele["label_id"] = name2id[ele["label_id"]]["id"]

        # TODO (mike): Add protection mechanism to avoid data loss.
        if override:
            self.log.info(f"Task {task_id:>5d}, Delete annotation start.")
            self.delete_annotations(task_id)
            self.log.info(f"Task {task_id:>5d}, Delete annotation done.")

        self.log.info(f"Task {task_id:>5d}, Upload annotation Start {file}.")
        try:
            response = self.patch_annotation(task_id, data=data)
        except Exception as e:
            # 504 Server Error: Gateway Timeout is not a matter for upload annotation
            if response.status_code != 504:
                raise e
        self.log.info(f"Task {task_id:>5d}, Upload annotation Done")

    def dump(self, task_id: int, dir: str, prefix_task_name: bool = False) -> None:
        info = self.check_existence(task_id, "Task")
        if not info:
            return

        name = info.get("name")
        os.makedirs(dir, exist_ok=True)
        prefix = ""
        if prefix_task_name:
            prefix = name
            for ch in (":", "[", "]", "(", ")", ";", "*", "{", "}", "`"):
                prefix = prefix.replace(ch, "")
            prefix = prefix.replace(" ", "_") + "_"

        fname = f"{prefix}annotations.json"
        outfile = os.path.join(dir, fname)
        labels = [label for labels in self.label_iter(task_id, "Task") for label in labels]

        label_id_to_name, attr_id_to_name = {}, {}
        tags, shapes, tracks = [], [], []

        data = self.get_annotations(task_id)

        with ThreadPoolExecutor(max_workers=10) as executor:

            def extract_mapping(label):
                for attr in label["attributes"]:
                    _id, name = attr["id"], attr["name"]
                    attr_id_to_name[_id] = name
                _id, name = label["id"], label["name"]
                label_id_to_name[_id] = name

            futures = [executor.submit(extract_mapping, label) for label in labels]
            for fut in futures:
                fut.result()

            def parse_track(obj):
                obj.pop("id")
                obj["label_id"] = label_id_to_name[obj["label_id"]]
                # Get the reamining attrs
                obj["attributes"] = [
                    dict(attr, spec_id=attr_id_to_name[attr["spec_id"]]) for attr in obj["attributes"]
                ]
                for shape in obj["shapes"]:
                    # Get the reamining attrs
                    shape["attributes"] = [
                        dict(attr, spec_id=attr_id_to_name[attr["spec_id"]]) for attr in shape["attributes"]
                    ]
                    shape.pop("id")
                tracks.append(obj)

            def parse_tag_shape(obj, typ):
                obj.pop("id")
                obj["label_id"] = label_id_to_name[obj["label_id"]]
                obj["attributes"] = [
                    dict(attr, spec_id=attr_id_to_name[attr["spec_id"]]) for attr in obj["attributes"]
                ]
                if typ == "tag":
                    tags.append(obj)
                elif typ == "shape":
                    shapes.append(obj)

            futs = [
                executor.submit(parse_tag_shape, obj, typ)
                for obj, typ in zip(
                    chain(data["tags"], data["shapes"]),
                    chain(repeat("tag", len(data["tags"])), repeat("shape", len(data["shapes"]))),
                )
            ] + [executor.submit(parse_track, obj) for obj in data["tracks"]]
            for fut in as_completed(futs):
                fut.result()
            data["tags"] = tags
            data["shapes"] = shapes
            data["tracks"] = tracks

        data = json.dumps(data).encode("utf-8")

        with open(outfile, "wb") as f:
            f.write(data)

        self.log.info(f"Task {task_id:>5d}, Task Annotation.")

    def source(self, task_id: int, dir: str) -> None:
        info = self.check_existence(task_id, _type="Task")
        if not info:
            return

        name = info.get("name")
        dir = os.path.join(dir, name)
        os.makedirs(dir, exist_ok=True)
        self.log.info(f"Task {task_id:>5d}, Task Source {os.path.join(dir, 'data')}")
        data = self.get_raw_data(task_id)
        with ZipFile(BytesIO(data), "r") as zf:
            name_list = zf.namelist()
            name_list.sort(key=natural_sort_key)
            for fname in name_list:
                if "data" not in fname:
                    continue
                base = os.path.basename(fname)
                ext = os.path.splitext(base)[1]
                if ext in (".json", ".jsonl"):
                    continue
                zf.extract(fname, dir)
        self.log.info(f"Task {task_id:>5d}, Task Source Done")

    def create(
        self,
        name: str,
        frame_step: int,
        resource: str,
        metadata: dict,
        anno_file: str = "",
        data_group: int = 300,
    ) -> None:
        """Create single task."""
        # Directory path to file paths
        if os.path.isdir(resource):
            resources = sorted(
                [os.path.join(resource, f) for f in os.listdir(resource)], key=natural_sort_key
            )
        else:
            resources = [resource]

        try:
            response = self.create_empty_task(metadata)
        except Exception:
            return self.log.error(f"Task {name}, {response.content}", exc_info=True)
        task_info = response.json()

        self.log.info("Task {id:>5d}, {name} Created".format(**task_info))

        # ---------------- Fuck You, CVAT ----------------
        try:
            task_id = task_info.get("id")
            self.attach_tasks_data(task_id, resources, frame_step, data_group)
        except Exception as e:
            return self.log.error(f"Task {task_id:>5d}, {e}", exc_info=True)
        # ---------------- Fuck You, CVAT ----------------

        if anno_file != "":
            self.upload(task_id, anno_file)

    def dele(self, _id: int, _type: str) -> None:
        if not self.check_existence(_id, _type):
            return
        self.log.info(f"{_type} {_id:>5d}, Delete start.")
        self.delete(_id, _type)
        self.log.info(f"{_type} {_id:>5d}, Delete done.")

    def delanno(self, task_id: int, types: list[str]) -> None:
        if not self.check_existence(task_id, _type="Task"):
            return

        if types == []:
            self.log.info(f"Task {task_id:>5d}, Delete Annotation Start")
            self.delete_annotations(task_id)
            self.log.info(f"Task {task_id:>5d}, Delete Annotation Done")
            return

        # Get annotation json data
        data = self.get_annotations(task_id)

        # If we didn't delete id, upload will fail.
        origin_tag_amount, origin_shape_amount, origin_track_amount = (
            len(data["tags"]),
            len(data["shapes"]),
            len(data["tracks"]),
        )
        data["tags"] = [] if "tag" in types else [tag.pop("id") and tag for tag in data["tags"]]
        data["shapes"] = [shape.pop("id") and shape for shape in data["shapes"] if shape["type"] not in types]
        data["tracks"] = [
            track.pop("id") and ((shape.pop("id") for shape in track["shapes"]) and track)
            for track in data["tracks"]
            if track["shapes"][0]["type"] not in types
        ]
        after_tag_amount, after_shape_amount, after_track_amount = (
            len(data["tags"]),
            len(data["shapes"]),
            len(data["tracks"]),
        )

        # Check differences.
        if (
            origin_tag_amount == after_tag_amount
            and origin_shape_amount == after_shape_amount
            and origin_track_amount == after_track_amount
        ):
            return self.log.info(f"Task {task_id:>5d}, Nothing Changed.")

        # Clear the existing annotations first.
        self.log.info(f"Task {task_id:>5d}, Delete Annotation Start")
        self.delete_annotations(task_id)
        self.log.info(f"Task {task_id:>5d}, Delete Annotation Done")

        # Then upload the actual data.
        self.log.info(f"Task {task_id:>5d}, Update Annotation Start.")
        try:
            response = self.patch_annotation(task_id, data=data, action="create")
        except Exception as e:
            # 504 Server Error: Gateway Timeout is not a matter for upload annotation
            if response.status_code != 504:
                raise e
        self.log.info(f"Task {task_id:>5d}, Update Annotation Done.")

    def delattr(self, project_id: int, labels: list[str], attributes: list[str]) -> None:
        """This is so fucking hard to make it works. Fucking idiot CVAT data handling.
        Why some will change while some will not, from a totally the same operation?
        And there's even no document, WTF is this.

        Args:
            project_id (int): Project id.
            labels (list[str]): Collections of labels.
            attributes (list[str]): Collection of attributes.

        """

        # TODO (mike): Add early stop points.
        curr_labels = [label for labels in self.label_iter(project_id, "Project") for label in labels]
        self.log.info(f"Project {project_id:>5d}, Label get.")
        with ThreadPoolExecutor(max_workers=4) as executor:
            label_id_to_name, attr_id_to_name = {}, {}

            def extract_mapping(label):
                for attr in label["attributes"]:
                    _id, name = attr["id"], attr["name"]
                    attr_id_to_name[_id] = name
                _id, name = label["id"], label["name"]
                label_id_to_name[_id] = name

            futures = [executor.submit(extract_mapping, label) for label in curr_labels]
            for fut in futures:
                fut.result()
            self.log.info(
                f"Project {project_id:>5d}, Old mapping get {label_id_to_name=}, {attr_id_to_name=}."
            )

            amount = self.project_task_page_amount(project_id)
            self.log.info(f"Project {project_id:>5d}, Fetching {amount} page tasks.")
            futures = [
                executor.submit(self.project_task_page, project_id, page) for page in range(1, amount + 1)
            ]
            task_ids = [obj.get("id") for fut in as_completed(futures) for obj in fut.result()]
            self.log.info(f"Project {project_id:>5d}, tasks get: {', '.join(map(str, task_ids))}")

            task_id_to_anno = {}

            # I've tried my best to let it be performant and clear.
            def get_feasible_anno(task_id):
                # Only choose matching (label, attribute) pair.
                anno = self.get_annotations(task_id)
                tags, shapes, tracks = [], [], []

                def parse_track(obj):
                    label_match: bool = label_id_to_name[obj["label_id"]] in labels
                    mut_attrs = tuple(  # mutable attribute
                        True
                        for attr in obj["shapes"][0]["attributes"]
                        if attr_id_to_name[attr["spec_id"]] in attributes
                    )
                    immut_attrs = tuple(  # immutable attribute
                        attr for attr in obj["attributes"] if attr_id_to_name[attr["spec_id"]] in attributes
                    )
                    attr_match: bool = len(mut_attrs) or len(immut_attrs)
                    if not (label_match and attr_match):
                        return

                    obj.pop("id")
                    obj["label_id"] = label_id_to_name[obj["label_id"]]
                    # Get the reamining attrs
                    obj["attributes"] = [
                        dict(attr, spec_id=attr_id_to_name[attr["spec_id"]])
                        for attr in obj["attributes"]
                        if attr_id_to_name[attr["spec_id"]] not in attributes
                    ]

                    for shape in obj["shapes"]:
                        # Get the reamining attrs
                        shape["attributes"] = [
                            dict(attr, spec_id=attr_id_to_name[attr["spec_id"]])
                            for attr in shape["attributes"]
                            if attr_id_to_name[attr["spec_id"]] not in attributes
                        ]
                        shape.pop("id")

                    tracks.append(obj)

                def parse_tag_shape(obj, typ):
                    label_match: bool = label_id_to_name[obj["label_id"]] in labels
                    remain_attrs = tuple(
                        attr
                        for attr in obj["attributes"]
                        if attr_id_to_name[attr["spec_id"]] not in attributes
                    )
                    attr_match = len(remain_attrs) != len(obj["attributes"])
                    if not (label_match and attr_match):
                        return
                    obj.pop("id")
                    obj["label_id"] = label_id_to_name[obj["label_id"]]
                    obj["attributes"] = [
                        dict(attr, spec_id=attr_id_to_name[attr["spec_id"]]) for attr in remain_attrs
                    ]
                    if typ == "tag":
                        tags.append(obj)
                    elif typ == "shape":
                        shapes.append(obj)

                futs = [
                    executor.submit(parse_tag_shape, obj, typ)
                    for obj, typ in zip(
                        chain(anno["tags"], anno["shapes"]),
                        chain(repeat("tag", len(anno["tags"])), repeat("shape", len(anno["shapes"]))),
                    )
                ] + [executor.submit(parse_track, obj) for obj in anno["tracks"]]
                for fut in as_completed(futs):
                    fut.result()
                if (len(tags) + len(shapes) + len(tracks)) == 0:
                    return self.log.info(f"  Task: {task_id}, Nothing to change.")
                anno["tags"] = tags
                anno["shapes"] = shapes
                anno["tracks"] = tracks
                task_id_to_anno[task_id] = anno

            self.log.info(f"Project {project_id:>5d}, Fetching old annotations.")
            futures = [executor.submit(get_feasible_anno, task_id) for task_id in task_ids]
            for fut in futures:
                fut.result()
            self.log.info(f"Project {project_id:>5d}, Old annotations get.")

            target_labels, to_remove_label_ids = [], []

            def extract_labels(label):
                label_match = label["name"] in labels
                attrs = tuple(attr for attr in label["attributes"] if attr["name"] in attributes)
                attr_match = len(attrs)
                if not (label_match and attr_match):
                    return
                without_id_label = label.copy()
                to_remove_label_ids.append(without_id_label.pop("id"))
                consume(
                    map(
                        without_id_label.pop,
                        ("color", "sublabels", "project_id", "parent_id", "has_parent"),
                    )
                )
                target_labels.append(
                    dict(
                        without_id_label,
                        # Only get the reamining
                        attributes=[
                            attr.pop("id") and attr
                            for attr in label["attributes"]
                            if attr["name"] not in attributes
                        ],
                    )
                )

            futures = [executor.submit(extract_labels, label) for label in curr_labels]
            for fut in futures:
                fut.result()

            self.log.info(f"Project {project_id:>5d}, Remove attributes start.")

            futures = [executor.submit(self.delete_label, label_id) for label_id in to_remove_label_ids]
            for fut in futures:
                fut.result()
            self.log.info(f"  Project {project_id:>5d}, Old label detele.")
            self.patch_label(project_id, data=dict(labels=target_labels))
            self.log.info(f"  Project {project_id:>5d}, New label create.")

            new_labels = [label for labels in self.label_iter(project_id, "Project") for label in labels]
            new_label_name_to_id, new_attr_name_to_id = {}, {}

            def extract_mapping(label):
                for attr in label["attributes"]:
                    _id, name = attr["id"], attr["name"]
                    new_attr_name_to_id[name] = _id
                _id, name = label["id"], label["name"]
                new_label_name_to_id[name] = _id

            futures = [executor.submit(extract_mapping, label) for label in new_labels]
            for fut in futures:
                fut.result()
            self.log.info(
                f"  Project {project_id:>5d}, New mapping get {new_label_name_to_id=}, {new_attr_name_to_id=}."
            )

            def map_name_back_to_id(task_id, anno):
                tags, shapes, tracks = [], [], []

                def parse_track(obj):
                    obj["label_id"] = new_label_name_to_id[obj["label_id"]]
                    for shape in obj["shapes"]:
                        for attr in shape["attributes"]:
                            attr["spec_id"] = new_attr_name_to_id[attr["spec_id"]]
                    for attr in obj["attributes"]:
                        attr["spec_id"] = new_attr_name_to_id[attr["spec_id"]]
                    tracks.append(obj)

                def parse_tag_shape(obj, typ):
                    obj["label_id"] = new_label_name_to_id[obj["label_id"]]
                    for attr in obj["attributes"]:
                        attr["spec_id"] = new_attr_name_to_id[attr["spec_id"]]
                    if typ == "tag":
                        tags.append(obj)
                    elif typ == "shape":
                        shapes.append(obj)

                futures = [
                    executor.submit(parse_tag_shape, obj, typ)
                    for obj, typ in zip(
                        chain(anno["tags"], anno["shapes"]),
                        chain(repeat("tag", len(anno["tags"])), repeat("shape", len(anno["shapes"]))),
                    )
                ] + [executor.submit(parse_track, obj) for obj in anno["tracks"]]
                for fut in futures:
                    fut.result()

                anno["tags"] = tags
                anno["shapes"] = shapes
                anno["tracks"] = tracks

                task_id_to_anno[task_id] = anno

            futures = [
                executor.submit(map_name_back_to_id, task_id, anno)
                for task_id, anno in task_id_to_anno.items()
            ]
            for fut in futures:
                fut.result()

            self.log.info(f"  Project {project_id:>5d}, New annotation get.")

            self.log.info(f"  Task {', '.join(task_id_to_anno.keys())}, Patch annotation start.")
            futures = [
                executor.submit(self.patch_annotation, task_id, anno)
                for task_id, anno in task_id_to_anno.items()
            ]
            for fut in futures:
                fut.result()
            self.log.info(f"  Task {', '.join(task_id_to_anno.keys())}, Patch annotation done.")
            self.log.info(f"Project {project_id:>5d}, Remove attributes done.")

    def task_recreate(self, project_id: int, task_dir: str, override_annotations: bool) -> None:
        if not os.path.isdir(task_dir):
            return self.log.warn(f"Task directory {task_dir} not found.")

        with open(os.path.join(task_dir, "task_metadata.json"), "r") as f:
            json_obj = json.load(f)

        founds = self.search(json_obj.get("name"), _type="Task", strict=True)
        if len(founds) > 1:
            ids = ", ".join([str(obj.get("id")) for obj in founds])
            self.log.error(
                f"{len(founds)} tasks with the same name {json_obj.get('name')} found: {ids}.\n"
                + "Never create multiple tasks with the same name. This will confuse the backup process.\n"
                + "Please go to the CVAT UI and change the existing task name.",
            )

        if len(founds) == 1:
            json_obj = founds[0]
            if override_annotations:
                self.log.warn(
                    "Task {name} exists, only override the annotations. Task Id: {id:>4d}, Url: {url}".format(
                        **json_obj
                    )
                )
                anno_file = os.path.join(task_dir, "annotations.json")
                self.upload(json_obj.get("id"), anno_file, override=True)
                return json_obj

            self.log.warn(
                "Task {name} exists, no actions are taken. Task Id: {id:>4d}, Url: {url}".format(**json_obj)
            )
            return json_obj

        # This settings are intentionally fixed.
        data = dict(name=json_obj.get("name"), overlap=json_obj.get("overlap"))
        if project_id != 0:
            data["project_id"] = project_id
        else:
            data["labels"] = json_obj.get("labels")

        response = self.create_empty_task(data)

        new_json_obj = response.json()
        self.log.info("Task {id:>5d}, {name} Created".format(**new_json_obj))

        data_folder = os.path.join(task_dir, "data")
        resources = os.listdir(data_folder)
        if len(resources) == 0:
            self.log.error(f"No file found in {data_folder}, task not create.")
            return
        resources = [os.path.join(data_folder, f) for f in resources]
        # Upload data
        try:
            frame_step = json_obj.get("frame_filter")
            frame_step = int(frame_step) if frame_step != "" else 1
            task_id = new_json_obj.get("id")
            self.attach_tasks_data(
                task_id,
                resources,
                frame_step,
                group=200,
            )
        except Exception as e:
            self.log.error(f"Task {task_id:>5d}, {e}", exc_info=True)

        anno_file = os.path.join(task_dir, "annotations.json")
        # print(task_id, anno_file)
        self.upload(task_id, anno_file, override=True)

    def project_recreate(self, project_dir: str) -> None:
        base_name = os.path.basename(os.path.normpath(project_dir))
        # `others` directory is the collection of single tasks (task has no project)
        if base_name == "others":
            return 0

        # Basic check.
        if not os.path.isdir(project_dir):
            self.log.warn(f"Project directory {project_dir} not found.")
            return

        with open(os.path.join(project_dir, "project_metadata.json"), "r") as f:
            json_obj = json.load(f)

        # First, search if there's any project has the same name.
        founds = self.search(json_obj.get("name"), _type="Project", strict=True)

        # Handle different search results.
        if len(founds) > 1:
            ids = ", ".join([str(obj.get("id")) for obj in founds])
            self.log.error(
                f"{len(founds)} projects with the same name {json_obj.get('name')} found: {ids}.\n"
                + "Never create multiple projects with the same name.\n"
                + "Please go to the CVAT UI and change the existing project name."
            )
            return

        # Found one project, return its id.
        if len(founds) == 1:
            json_obj = founds[0]
            self.log.info(
                "Proj {name} exists, recreating tasks in it. Project Id: {id:>4d}, Url: {url}".format(
                    **json_obj
                )
            )
            return json_obj.get("id")

        # When no project found, create it.
        try:
            response = self.create_empty_project(
                data=dict(
                    name=json_obj.get("name"),
                    labels=json_obj.get("labels"),
                )
            )
        except Exception:
            return self.log.error(
                f"{json_obj.get('name')}, {response.content}",
                exc_info=True,
            )

        new_json_obj = response.json()
        self.log.info("Proj {id:>5d}, {name} Created.".format(**new_json_obj))
        return new_json_obj.get("id")

    def task_backup(
        self,
        task_info: dict,
        project_name: dict,
        dir: str,
        download_source: bool = True,
    ) -> str:
        """This method will create a dedicated folder structrue for tasks recreation.
        Backup basically does the following steps in order:

        1. Parse task information
        2. Get task's source data
        3. Get tasks's annotation

        """
        task_id = task_info.get("id")
        info_s = f"Task {task_id:>5d}"

        # Remove bad character
        for ch in (":", "[", "]", "(", ")", ";", "*", "{", "}", "`"):
            project_name = project_name.replace(ch, "")
        project_name = project_name.replace(" ", "_")

        # projcet folder
        project_dir = os.path.join(dir, f"{project_name}")

        # task folder handle
        task_name = task_info.get("name")

        # Handle more bad character
        for ch in (":", "[", "]", "(", ")", ";", "*", "{", "}", "`"):
            task_name = task_name.replace(ch, "")
        task_name = task_name.replace(" ", "_")

        # task folder
        task_dir = os.path.join(project_dir, task_name)
        info_s += f", {task_dir}"

        try:
            # create task folder
            os.makedirs(task_dir, exist_ok=True)

            # task metadata
            task_meta = self.meta(task_id, "Task")
            task_meta_file = os.path.join(task_dir, "task_metadata.json")
            r_json = self.session.get(task_info["labels"]["url"]).json()
            labels = r_json["results"]
            while r_json["next"]:
                r_json = self.session.get(r_json["next"]).json()
                labels += r_json["results"]

            # These will cause request error when uploading
            for label in labels:
                label.pop("type", None)
                label.pop("sublabels", None)
                label.pop("has_parent", None)

            json_obj = json.dumps(
                {
                    "name": task_name,
                    "version": self.version,
                    "overlap": task_info["overlap"],
                    "segment_size": task_info["segment_size"],
                    "labels": labels,
                    "data_chunk_size": task_info["data_chunk_size"],
                    "data_compressed_chunk_type": task_info["data_compressed_chunk_type"],
                    "updated_date": task_info["updated_date"],
                    "created_date": task_info["created_date"],
                    "frame_filter": task_meta["frame_filter"].replace("step=", ""),
                },
                indent=4,
            )
            # save task metadata
            with open(task_meta_file, "w") as f:
                f.write(json_obj)
            self.log.info(f"Task {task_id:>5d}, Task Meta {task_meta_file}")

            # download task's source data
            # Check if this is the first creation
            data_dir = os.path.join(task_dir, "data")
            dir_exists = os.path.exists(data_dir)
            new_backup = (not dir_exists) or (dir_exists and len(os.listdir(data_dir)) == 0)
            if new_backup or download_source:
                self.source(task_id, task_dir)
            else:
                self.log.info(f"Task {task_id:>5d}, Source Not download")

            # annotation
            self.dump(task_id, task_dir)
            self.log.info(f"Task {task_id:>5d}, Done")
            return task_name
        except (IOError, httpx.HTTPError, httpx.StreamError) as e:
            return task_id, e

    def project_backup(self, project_info: dict, dir: str) -> str:
        """This method will only create project folder and save a project_metadata.json"""
        # single task backup to others/
        project_name = "others"

        if project_info:
            project_name = project_info.get("name")
            # Remove bad character
            for ch in (":", "[", "]", "(", ")", ";", "*", "{", "}", "`"):
                project_name = project_name.replace(ch, "")
            project_name = project_name.replace(" ", "_")

        # projcet folder
        project_dir = os.path.join(dir, f"{project_name}")

        # Collect those failed projects
        try:
            # create project folder
            os.makedirs(project_dir, exist_ok=True)

            # belongs to a project
            if not project_info:
                self.log.info("Proj others, Single tasks found.")
                return

            r_json = self.session.get(project_info["labels"]["url"]).json()
            labels = r_json["results"]
            while r_json["next"]:
                r_json = self.session.get(r_json["next"]).json()
                labels += r_json["results"]

            # These will cause request error, when uploading
            for label in labels:
                label.pop("type", None)
                label.pop("sublabels", None)
                label.pop("has_parent", None)

            # project metadata
            json_obj = json.dumps(
                {
                    "name": project_name,
                    "version": self.version,
                    "labels": labels,
                    "updated_date": project_info["updated_date"],
                    "created_date": project_info["created_date"],
                },
                indent=4,
            )
            project_meta_file = os.path.join(project_dir, "project_metadata.json")
            # save project metadata
            with open(project_meta_file, "w") as f:
                f.write(json_obj)
            self.log.info(f"Proj {project_info.get('id'):>5d}, Proj Meta {project_meta_file}")
            return project_name
        except (IOError, httpx.HTTPError, httpx.StreamError) as e:
            return project_info.get("id"), e
