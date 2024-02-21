Tools
-----

+ [VcXrv](https://sourceforge.net/projects/vcxsrv/): For WSL's X server.
+ [cuda](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/contents.html): Header files for c/c++ nvidia gpu programming.
+ [WinDbg](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/): Lightweight debugger than fat and slow VS.
+ [AltSnap](https://github.com/RamonUnch/AltSnap/releases), [QuickLook](https://github.com/QL-Win/QuickLook/releases), [ZoomIt](https://learn.microsoft.com/en-us/sysinternals/downloads/zoomit): Useful tools.
+ [AutoHotKey](https://www.autohotkey.com/): Let you be able to use Win+M to minimize window.

WSL Dev Environment Setup
-------------------------

With WSL specific options answering y.
```bash
./ubuntu/sudo_install.sh
./ubuntu/local_install.sh
```


# F**K u MS. Why everything on you is so complicated?


Cmd Dev Environment Setup
-------------------------

1. Cuz MS's strange UI oriented design and [no sudo](https://devblogs.microsoft.com/commandline/introducing-sudo-for-windows/) command, lots of installations require you to use mouse and wait for the slow installation progress.
Writing auto-install script is just overwhelming.
2. Don't use powershell for daily development, it's so laggy.

### First and first

1. Download [PowerShell](https://www.microsoft.com/store/productId/9MZ1SNWT0N5D?ocid=pdpshare) from Microsoft Store. Yes, it's different from the builtin one. Surprised? First time?
2. Install the bloated and laggy [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/?q=build+tools#build-tools-for-visual-studio-2022).
3. Change execution policy in powershell. Without setting this, you can't run ps1 file and install scoop.

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Use Powershell First

```powershell
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

```powershell
scoop install curl wget gcc grep lsd which touch less findutils llvm nodejs yarn pkg-config coreutils git oh-my-posh
mkdir $env:PROFILE\.local
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\Users\User\.local\bin", 'User')
```

```powershell
git clone https://github.com/youngtuotuo/dotfiles.git $HOME/github/dotfiles
```

```powershell
./windows/setup.ps1
```

### Second, use command prompt

```bat
windows/setup.bat
```

Finally, reopen the command prompt.

### Build Neovim

Convenient one liner

```powershell
dev && cmake --build .deps --target clean && cmake --build build --target clean && cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release && cmake --build .deps --config Release && cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=%USERPROFILE%\.local && cmake --build build --config Release --target install && rm -rf %USERPROFILE%\.local\lib\nvim\parser\*.dll
```

NOTE: `dev` is the function in `clink_start.cmd` or `Microsoft.PowerShell_profile.ps1` that enables the visual studio environment for command prompt or powershell, respectively.

### AutoHotKey

Remember to use `minimize.ahk` to enable `Win+m` to minized any window.


### Execution Policy

```powershell
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope CurrentUser/LocalMachine/etc.
```

### Frequently used envs

Powershell

```powershell
dir env:
cd $env:APPDATA
cd $env:LOCALAPPDATA
cd $env:USERPROFILE
vi $PROFILE
```

Command Prompt

```bat
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

