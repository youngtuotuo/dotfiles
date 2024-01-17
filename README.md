# Dotfiles

This repo includes:

- Tools I use for data science development in ubuntu/mac/windows/wsl.
- Tools config files.
- Url or Installation scripts that hard to find by simply google once.

![image](pictures/startup.png)

## Easy Install Tools

Tools listed here can be found by goolging once.

### All OS

Wezterm, Wireguard, OpenVPN Client, miniconda, Git Credential Manager, Clang >= 16,\
llvm >= 16, lld >= 16, Nodejs, Npm

### MacOS

Brew, Clipboard Inidicator, AltTab, Rectangle, zsh-autosuggestions,\
Karadiner-Elements, [Easy-Move-Resize(100hz v.)](https://drive.google.com/file/d/1bdyYV0fyfmAnF1Lla08BVVKNLJTMiQwU/view?usp=drive_link)

### Windows, WSL (ubuntu 20.04 prefer)

PowerShell, Git for windows, VcXrv, Scoop, cuda, AllStartBack, noVNC,\
AltSnap, QuickLook, ZoomIt

## Complicated ones

### One for all dependicies

```bash
sudo apt-get install zstd ninja-build gettext libtool libtool-bin autoconf \
    automake cmake g++ pkg-config unzip curl doxygen -y build-essential \
    clang libevent-dev ncurses-dev build-essential bison pkg-config git fd ripgrep

echo 'export PATH=$HOME/.local/bin${PATH:+:${PATH}}' >> ~/.bashrc
ln -s $(which fdfind) ~/.local/bin/fd
# nodejs
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
# yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | \
    sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | \
    sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
```

### Clangd Language Server Configuration

For `#include <Python.h>`, put this file to projcet root:

```bash
cp ~/github/dotfiles/compile_flags.txt .
```

Remember to remove unused flags.

Run this command to get the path of `Python.h`.

```bash
python -c "import sysconfig; print(sysconfig.get_paths())"
```

### Zig

Install llvm first.\
[apt.llvm.org](https://apt.llvm.org/)

```bash
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 16 all
sudo apt install liblld-16 liblld-16-dev
```

[Building Zig from Source](https://github.com/ziglang/zig/wiki/Building-Zig-From-Source)

```bash
mkdir build
cd build
cmake ..
make install
```

### Miniconda disalbe prompt

```bash
conda config --system --set env_prompt ""
conda config --set auto_activate_base false
```

## Mason Legacy Haskell Language Server Version

```bash
ghcup install ghc-9.2.7
```

Linux/Mac

```bash
rm ~/.ghcup/bin/ghc && ln -s ~/.ghcup/ghc/9.2.7/bin/ghc-9.2.7  ~/.ghcup/bin/ghc
```

PowerShell

```bash
rm C:\ghcup\bin\ghc.exe
cp C:\ghcup\bin\ghc-9.2.7.exe C:\ghcup\bin\ghc.exe
```

### Cuda

[reference](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)

```bash
sudo apt-get install linux-headers-$(uname -r)
# you can find the feasible choices here https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#network-repo-installation-for-ubuntu
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo apt-get install cuda -y
```

### Neovim

Ubuntu

```bash
# Build from Source
git clone https://github.com/neovim/neovim.git
cd neovim
sudo CMAKE_BUILD_TYPE=Release make && sudo make install
```

Mac (homebrew)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap austinliuigi/brew-neovim-nightly https://github.com/austinliuigi/brew-neovim-nightly.git
brew install neovim-nightly
```

Install Config for Neovim

```bash
mkdir ~/github
git clone https://github.com/youngtuotuo/dotfiles.git ~/github/dotfiles
ln -s ~/github/dotfiles/nvim/ ~/.config/nvim
```

Pyright Related [Configuration](https://github.com/microsoft/pyright/blob/main/docs/configuration.md)

### Latex Compiler

```bash
sudo apt install texlive-latex-base texlive-fonts-recommended \
    texlive-fonts-extra texlive-latex-extra texlive-xetex \
    latexmk -y
```

### Solve cv2 typing issue with Pyright

By adding the `__init__.pyi` file, you'll get suggestion from Pyright.\

```bash
cd ~/github/dotfiles
cp cv2/__init__.pyi $VIRTUAL_ENV/lib/python3.8/site-packages/cv2/__init__.pyi
```

### tigerVNC

Not work in WSL2.

```bash
sudo apt install tigervnc-standalone-server xfce4 xfce4-goodies
# setup password
vncserver :2
vncserver -kill :2
sudo cp ~/github/dotfiles/xstartup ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup
```

Useful vnc commands

```bash
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

### PowerShell config

[devaslife setup](https://www.youtube.com/watch?v=5-aK2_WwrmM&t=540s)

Load path:

```powershell
mkdir ~/github
~/Documents/PowerShell/profile.ps1
```

Install clang

```powershell
scoop install main/llvm
```

Envs

```powershell
dir env:
```

Frequently used envs

```powershell
cd $env:APPDATA
cd $env:LOCALAPPDATA
cd $env:USERPROFILE
```

Execution Policy

```powershell
Get-ExecutionPolicy -List
Set-ExecutionPolicy -Scope CurrentUser/LocalMachine/etc.
```

Windows Terminal\
"liga" is useless. Use "calt" to disable ligature.

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

### WSL2 config

Git credential manager

```bash
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
```
