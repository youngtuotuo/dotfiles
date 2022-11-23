# Dotfiles
My routine data science envrionment set up in ubuntu/mac/windows.

<p align="center">
    <img src="pictures/image.png" />
</p>

## Neovim Shortcut
1. select python code and press `\p` -> execute the selected codes
2. press `\p`  -> execute current whole python file
3. press `\g+` -> compile current cpp code and execute the binary (vimpp.out)
4. press `\gc` -> compile current c code and execute the binary (vimc.out)
6. press `\ss` -> toggle line numbers and relative line numbers
7. press `\ts` -> toggle treesitter highlight

## Tmux Shortcut
1. `<c-b>>` move current window right
2. `<c-b><` move current window right
3. `<c-b>\` horizontal split
3. `<c-b>|` vertical split



# Ubuntu/Mac

## Ubuntu Specific

```bash
    $ sudo apt-get update
    $ sudo apt-get upgrade -y
    $ sudo apt install openssh-server build-essential git tmux -y
    $ sudo apt install gnome-tweaks -y
    $ sudo apt install dconf-editor -y
```

Change Keyboard and Mouse Behavior:
1. Use Tweaks app to change caps to ctrl.
2. Use dconf-editor to change click on app icon be 'minimize-and-preview'.
    (org/gnome/shell/extensions/dash-to-dock/click-action)
3. (Optional) Disable laptop keybard: `xinput disable "AT Translated Set 2 keyboard"`


### Install Slack, Discord, GIMP, Brave and Spotify

[https://slack.com/downloads/linux](https://slack.com/downloads/linux)<br>
[https://discord.com/](https://discord.com/)<br>
Download GIMP and Spotify from Ubuntu Software Store.

```bash
    $ sudo apt install apt-transport-https curl
    $ sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    $ echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    $ sudo apt update
    $ sudo apt install brave-browser -y
```

### Install clipboard Indicator
[https://extensions.gnome.org/extension/779/clipboard-indicator/](https://extensions.gnome.org/extension/779/clipboard-indicator/)

### Install Alacritty
[https://github.com/alacritty/alacritty/blob/master/INSTALL.md](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

### Install Fira Code Nerd Font
[https://github.com/ryanoasis/nerd-fonts/releases](https://github.com/ryanoasis/nerd-fonts/releases)

### Install Miniconda
[https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)

### Install Docker and CVAT
[https://opencv.github.io/cvat/docs/administration/basics/installation/](https://opencv.github.io/cvat/docs/administration/basics/installation/)

### Install Git-Credential-Manager
[https://github.com/GitCredentialManager/git-credential-manager/releases](https://github.com/GitCredentialManager/git-credential-manager/releases)
```bash
    $ sudo dpkg -i <path-to-package>
    $ git-credential-manager configure
```

### Install Cuda
[https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)<br>
WARNING: the ubuntu2004/x86_64 in the url may be different, remember to change.

```bash
    $ sudo apt-get install linux-headers-$(uname -r)
    $ wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
    $ sudo dpkg -i cuda-keyring_1.0-1_all.deb
    $ sudo apt-get update
    $ sudo apt-get install cuda -y
```

### Install Node and Yarn
[Node Install Instructions](https://github.com/nodesource/distributions/blob/master/README.md#debinstall)
```bash
    $ curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs
    $ sudo npm install --global yarn
```

### Install Neovim

#### Ubuntu

Install Dependicies
```bash
    $ sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
```

Build from Source
```bash
    $ git clone https://github.com/neovim/neovim.git
    $ cd neovim
    $ sudo make -j$(nproc) CMAKE_BUILD_TYPE=Release && sudo make CMAKE_BUILD_TYPE=Release install
```

#### Mac (homebrew)

```bash
    $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    $ brew install --HEAD neovim
```

### Install Plugin Manager

```bash
    $ git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Install Configuration

```bash
    $ git clone git@github.com:youngtuotuo/dotfiles.git ~/github/dotfiles
    $ ln -s ~/github/dotfiles/nvim/ ~/.config/nvim
```

### Open Neovim and Install Plugins

```bash
    :PackerSync
    :TSUpdateSync
```

### Intsall Latex Compiler

#### Ubuntu

```bash
    $ sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texlive-xetex latexmk -y
```

#### Mac
TBD


### Install Pdf viewer for VimTex

#### Ubuntu

```bash
    $ sudo apt install zathura -y
```

#### Mac
TBD


### Install Rust

```bash
    $ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    $ source "$HOME/.cargo/env"
```

### Install nu shell
[https://www.nushell.sh/book/installation.html#installing-rust](https://www.nushell.sh/book/installation.html#installing-rust)

### Install Latex LSP - Texlab

```bash
    $ cargo install texlab
```

### Install Python LSP - Pyright

```bash
    $ sudo npm install --global pyright
```

### Install C/C++ LSP - clangd


#### Ubuntu

```bash
    $ sudo apt install clangd-12 -y
    $ sudo ln /usr/bin/clangd-12 /usr/bin/clangd
```

#### Mac
TBD


### Install C/C++ Complier - clang


#### Ubuntu

```bash
    $ sudo apt install clang-12 -y
    $ sudo ln /usr/bin/clang-12 /usr/bin/clang
    $ sudo ln /usr/bin/clang-12 /usr/bin/clang++
```

#### Mac
TBD

# Windows

### Install scoop and Neovim

```powershell
    $ irm get.scoop.sh | iex
    $ scoop bucket add extras
    $ scoop bucket add versions
    $ scoop install vcredist2022
    $ scoop install neovim-nightly
    $ scoop install neovim-nightly
```

### Install Plugin Manager
```powershell
    $ git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"```
```

### Install Configuration

```powershell
    $ git clone git@github.com:youngtuotuo/dotfiles.git ~/github/dotfiles
    $ New-Item -ItemType SymbolicLink -Path "C:\Users\User\AppData\Local\nvim" -Target "C:\Users\User\github\dotfiles\nvim"
```

## cv2 typing issue with Pyright
`opencv-python` or `opencv-contrib-python` is unable to be resolved by Pyright.<br>
By adding the `__init__pyi` file, you'll get suggestion from Pyright.<br>
(Remember to chage `target env name` and `python3.x` to your case.)
```bash
    $ conda activate <target env name>
    $ cd dotfiles
    $ cp cv2/__init__.pyi $CONDA_PREFIX/lib/<python3.x>/site-packages/cv2/__init__.pyi
```

## TODO
Ubuntu/Mac setup
- [ ] Auto setup shell script

Windows setup
- [ ] Auto setup powershell script

