Dotfiles
========

This repo includes:

- Tools I use for data science development in ubuntu/mac/windows/wsl.
- Tools' config files.
- Url or Installation scripts that hard to find by simply google once.

Easy Install Tools
------------------

Tools listed here can be found by goolging once. So they will not be installed by scripts.

### All OS

Wezterm, Wireguard, OpenVPN Client

### MacOS

Clipboard Inidicator, AltTab, Rectangle, zsh-autosuggestions, noVNC,\
Karadiner-Elements, [Easy-Move-Resize(100hz v.)](https://drive.google.com/file/d/1bdyYV0fyfmAnF1Lla08BVVKNLJTMiQwU/view?usp=drive_link)

### Windows

PowerShell, Git for windows, VcXrv, Scoop, cuda,\
AltSnap, QuickLook, ZoomIt, AutoHotKey, WinDbg

Hard Install Tools
------------------

### Ubuntu/WSL

```
./ubuntu/sudo_install.sh
./ubuntu/local_install.sh
```

### Mac

```
./mac/mac_install.sh
```

### Windows

```powershell
WIP (Maybe I will never create this)
```

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

tigerVNC & noVNC
--------

- Run tigerVNC part in `./ubuntu/sudo_install.sh`

### tigerVNC

**NOTE**: Not work in WSL2. You need to use VcXsrv instead.

```bash
vncserver :2
vncserver -kill :2
vncserver -list
vncserver -kill
vncserver -localhost no -geometry 1920x1080
```

### noVNC

```bash
git clone https://github.com/novnc/noVNC ~/github/noVNC
pip install numpy
./utils/novnc_proxy --vnc <host>:5901
```

PowerShell config
-----------------

 1. [devaslife setup](https://www.youtube.com/watch?v=5-aK2_WwrmM&t=540s)
 2. Download PowerShell from Microsoft Store

### Load path

```powershell
mkdir ~/github
git clone https://github.com/youngtuotuo/dotfiles.git ~/github/dotfiles
cp ~/github/dotfiles/windows/Microsoft.PowerShell_profile.ps1 ~/Documents/PowerShell/
```

### Frequently used envs

```powershell
dir env:
cd $env:APPDATA
cd $env:LOCALAPPDATA
cd $env:USERPROFILE
```

### Execution Policy

```powershell
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope CurrentUser/LocalMachine/etc.
```

### Windows Terminal Disable ligature

"liga" is useless.

```json
{
    "font":
        {
            "face": "CaskaydiaCove Nerd Font",
            "features":
            {
                "liga": 0,
                "calt": 0,
            },
            "size": 12.0,
            "weight": "normal"
        },
}
```
