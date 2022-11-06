# My Routine Development Set Up in Ubuntu/Mac/Windows

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

#### Ubuntu

```bash
    $ sudo apt-get update
    $ sudo apt-get upgrade -y
    $ sudo apt install openssh-server build-essential git tmux
```


### Download Hack Nerd Font
[https://github.com/ryanoasis/nerd-fonts/releases](https://github.com/ryanoasis/nerd-fonts/releases)

### Download Anaconda
[https://docs.anaconda.com/anaconda/install/](https://docs.anaconda.com/anaconda/install/)

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
    $ sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
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
    $ sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texlive-xetex latexmk
```

#### Mac
TBD


### Install Pdf viewer for VimTex

#### Ubuntu

```bash
    $ sudo apt install zathura
```

#### Mac
TBD


### Install Rust

```bash
    $ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    $ source "$HOME/.cargo/env"
```

### Install Latex LSP - Texlab

```bash
    $ cargo install texlab
```

### Install Python LSP - Pyright

```bash
    $ sud npm install --global pyright
```

### Install C/C++ LSP - clangd


#### Ubuntu

```bash
    $ sudo apt install clangd-12
    $ sudo ln /usr/bin/clangd-12 /usr/bin/clangd
```

#### Mac
TBD


### Install C/C++ Complier - clang


#### Ubuntu

```bash
    $ sudo apt install clang-12
    $ sudo ln /usr/bin/clang-12 /usr/bin/clang
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

## cv2 typing issue
Remember to chage `target env name` and `python3.x` to suitable case.
```bash
    $ conda activate <target env name>
    $ cd dotfiles
    $ cp cv2/__init__.pyi $CONDA_PREFIX/lib/<python3.x>/site-packages/cv2/__init__.pyi
```

## TODO
Ubuntu setup
- [ ] Auto setup bash script
- [ ] Rust Analyzer Setup

Windows setup
- [ ] Auto setup powershell script
- [ ] Rust Analyzer Setup

MacOS setup
- [ ] Auto setup shell script
