Tools
-----

+ [cuda](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/contents.html): Header files for c/c++ nvidia gpu programming.
+ [AltSnap](https://github.com/RamonUnch/AltSnap/releases), [QuickLook](https://github.com/QL-Win/QuickLook/releases), [ZoomIt](https://learn.microsoft.com/en-us/sysinternals/downloads/zoomit): Useful tools.
+ [AutoHotKey](https://www.autohotkey.com/): Let you be able to use Win+M to minimize window.

cuda dev
--------
`.clangd` file at the project root.

```
CompileFlags:
  Add:
    - -std=c++14
    - --cuda-path=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.3
    - --cuda-gpu-arch=sm_86
    - -LC:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.3\lib\x64
    - -IC:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.3\include
```

For `--cuda-gpu-arch`, 
[https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/](https://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/)

# F**K u MS. Why everything on you is so complicated?

Dev Environment Setup
-------------------------

### First and first

1. Install the bloated and laggy [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/?q=build+tools#build-tools-for-visual-studio-2022).
2. Install PowerShell from winget

```console
winget install --id Microsoft.Powershell --source winget
```

3. Change execution policy in powershell. Without setting this, you can't run ps1 file and install scoop.

```console
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Powershell

Install scoop

```console
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

### Build Neovim

Convenient one liner in PowerShell.

```console
C:\'Program Files (x86)\Microsoft Visual Studio'\2022\BuildTools\Common7\Tools\Launch-VsDevShell.ps1 -Arch amd64; cmake --build .deps --target clean; cmake --build build --target clean; cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release; cmake --build .deps --config Release; cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=$env:USERPROFILE\.local; cmake --build build --config Release --target install
```

### AutoHotKey

Remember to use `minimize.ahk` to enable `Win+m` to minized any window.


### Execution Policy

```console
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope CurrentUser/LocalMachine/etc.
```

### Frequently used envs

Powershell

```console
ls env:
cd $env:APPDATA
cd $env:LOCALAPPDATA
cd $env:USERPROFILE
nvim $PROFILE
```

### Windows Terminal Disable ligature

`calt` is what you need, not `liga`.

```json
{
    "font":
        {
            "face": "...",
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

