Tools
-----

+ [cuda](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/contents.html): Header files for c/c++ nvidia gpu programming.
+ [AltSnap](https://github.com/RamonUnch/AltSnap/releases), [QuickLook](https://github.com/QL-Win/QuickLook/releases), [ZoomIt](https://learn.microsoft.com/en-us/sysinternals/downloads/zoomit): Useful tools.
+ [AutoHotKey](https://www.autohotkey.com/): Let you be able to use Win+M to minimize window.

# Nu-shell

I prefer using nu-shell now.

```console
winget install nu-shell
```

# F**K u MS. Why everything on you is so complicated?


Cmd Dev Environment Setup
-------------------------

### First and first

1. Install the bloated and laggy [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/?q=build+tools#build-tools-for-visual-studio-2022).
2. Change execution policy in powershell. Without setting this, you can't run ps1 file and install scoop.

```console
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Use Powershell First

```console
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

```console
scoop install gcc llvm nodejs yarn git
mkdir $env:PROFILE\.local
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\Users\User\.local\bin", 'User')
```

```console
git clone https://github.com/youngtuotuo/dotfiles.git $HOME/github/dotfiles
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA/nvim -Target $HOME/github/dotfiles/nvim
```

### Second, use command prompt

```console
windows/setup.bat
```

Finally, reopen the command prompt.

### Build Neovim

Convenient one liner

```console
dev && cmake --build .deps --target clean && cmake --build build --target clean && cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release && cmake --build .deps --config Release && cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=%USERPROFILE%\.local && cmake --build build --config Release --target install
```

NOTE: `dev` is the function in `clink_start.cmd` that enables the visual studio environment for command prompt.

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
dir env:
cd $env:APPDATA
cd $env:LOCALAPPDATA
cd $env:USERPROFILE
vi $PROFILE
```

Command Prompt

```console
env
cd %APPDATA%
cd %LOCALAPPDATA%
cd %USERPROFILE%
vi %PROFILE%
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

