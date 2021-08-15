# Vallina Non-Maximum Suppression(NMS)
## Assumption

> Bounging boxes that highly overlap to each other stand for the same object.

That means NMS is designed for images with objects not too close to each other.  
It's obvious tha NMS can't behave well for all cases.

## Method
Maunally define two thresholds `iou_thres=M`, `0<=M<=1` and `conf_thres=N`, `0<=N<=1`.
> Let ``A`` and ``B`` be two bounding boxes. ``IoU(A,B) >(=) M`` means ``A`` and ``B`` are highly overlapping.

```mermaid
    graph TD
        A["Detecetor(yolor, yolov4, SSD, etc.)"] --> B{"All boxes(S)"}
        B --> C["Pick one box B which has the highest confidence(but not less than N)"]
        B --> D["Other boxes (S - B)"]
        C --> |"Add B to the final output(O)"|E["Compute IoU of B w.r.t. all boxes in (S - B)"]
        D --> E
        E --> |Assumption: Large IoU means highly overlapping with B|F["Delete boxes in (S - B) that have IoU larger than M"]
        F --> |"Let the remaining boxes of (S - B) be R"|G[Check if R is empty]
        G --> |Yes|H[Return O]
        G --> |No|I[Let S=R]
        I --> B
```

## Pros and Cons
1. When the assumption is satisfied, NMS is **mostly** useful. Here are some scenarios that NMS is robust enough:
    - Satellite images: Ships, vehicles and buildings are almost impossible to overlap each other in this shooting angle.
    - Metal detector in customs.
    - Product counting on a conveyor belt.
    - Detect endanger species.
    - Detect illegal object.
    - Detect license plate in the entrence/exit of parking lot.

2. In reality, NMS can't fulfill most needs.
    - Crowd detections.
    - Car detections on the road/in the parking lot.
    - Product detections on a shelf.
    - Garbage detections.
    - Any targets that is easy to appear in group.
