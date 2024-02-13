Dotfiles
========

- Tools I use for data science development in ubuntu/mac/windows/wsl.
- Setup scripts.

Cross Platform Tools
--------------------

Wezterm, Wireguard, OpenVPN Client

Platform Specific
-----------------

Please refers to corresponding directory.


Neovim
------

### Clangd's Extremely not user-friendly compile_commands.json

- It's normal that you think the [official document](https://clang.llvm.org/docs/JSONCompilationDatabase.html#format) is opaque.

- If you have this compile command:

    ```console
    clang -O0 -g -o main file1.c file2.c file3.c
    ```

    You need compile_commands.json like:

    ```json
    [
      {
        "arguments": [
          "abs/path/to/compiler",
          "-c",
          "-O0",
          "-g",
          "-o",
          "main",
          "file1.c"
        ],
        "directory": "project/abs/path",
        "file": "abs/path/to/file1.c",
        "output": "abs/path/to/main"
      },
      {
        "arguments": [
          "abs/path/to/compiler",
          "-c",
          "-O0",
          "-g",
          "-o",
          "main",
          "file2.c"
        ],
        "directory": "project/abs/path",
        "file": "abs/path/to/file2.c",
        "output": "abs/path/to/main"
      },
      {
        "arguments": [
          "abs/path/to/compiler",
          "-c",
          "-O0",
          "-g",
          "-o",
          "main",
          "file3.c"
        ],
        "directory": "project/abs/path",
        "file": "abs/path/to/file3.c",
        "output": "abs/path/to/main"
      }
    ]
    ```

- To resolve `#include <Python.h>`, run the following command to get the path of `Python.h`

    ```console
    python -c "import sysconfig; print(sysconfig.get_paths()['include'])"
    # or
    python3 -c "import sysconfig; print(sysconfig.get_paths()['include'])"
    # or
    pkg-config --libs --cflags python
    # or
    pkg-config --libs --cflags python3
    ```

    , and, add

    ```
    -I/path/to/Python.h
    ```

    into your `compile_commands.json`.
