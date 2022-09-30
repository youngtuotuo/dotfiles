# Customize Firefox
I use WaveFox https://github.com/QNetITQ/WaveFox.

Set `full-screen-api.ignore-widgets` to true will limit full screen inside firefox window

<p align="center">
    <img src="pictures/firefox.png" />
</p>



# Neovim
<p align="center">
    <img src="pictures/alpha.png" />
</p>
<p align="center">
    <img src="pictures/neovimscreenshot.png" />
</p>

## Useful shortcut
1. select python code and press `\p` -> execute the selected codes
2. press `\p` -> relatively execute($python -m x.y.z) current whole python file
3. press `\g+` -> compile current cpp code and execute the binary(vimpp.out)
4. press `\gc` -> compile current c code and execute the binary(vimc.out)
6. press `\ss` -> toggle nu & rnu
7. press `\ts` -> toggle treesitter highlight


## Install Neovim
```bash
    $ sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    $ git clone https://github.com/neovim/neovim.git
    $ cd neovim && sudo make -j16 CMAKE_BUILD_TYPE=Release && sudo make CMAKE_BUILD_TYPE=Release install
```

## Install Neovim configuration
```bash
    $ git clone git@github.com:youngtuotuo/dotfiles.git ~/projects/dotfiles
```
Linux/Mac
```bash
    $ ln ~/projects/dotfiles/nvim/ ~/.config/nvim
```

Windows
```powershell
    $ New-Item -ItemType SymbolicLink -Path "~/AppData/Local/nvim" -Target "~/projects/dotfiles/nvim"
```

## Intsall Latex Compiler
```bash
    $ sudo apt install texlive-latex-base
    $ sudo apt install texlive-fonts-recommended
    $ sudo apt install texlive-fonts-extra
    $ sudo apt install texlive-latex-extra
    $ sudo apt install xelatex
    $ sudo apt install latexmk
```

## Install Latex LSP - Texlab

```bash
    $ cargo install texlab
```

## Install Python LSP - Python Language Server
```bash
    $ pip install "python-lsp-server[all]"
```

## Install Plugin manager
Linux/Mac
```bash
    $ git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
Windows
```powershell
    $ git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"```
```

## cv2 typing issue
Remember to chage `target env name` and `python3.x` to suitable case.
```bash
    $ conda activate <target env name>
    $ cd dotfiles
    $ cp cv2/__init__.pyi $CONDA_PREFIX/lib/<python3.x>/site-packages/cv2/__init__.pyi
```

## Install ccls
[Details](https://github.com/MaskRay/ccls/wiki/Build)<br>
Ubuntu 2204
```bash
    $ sudo apt-get install clang clang-dev
    $ git clone --depth=1 --recursive https://github.com/MaskRay/ccls && cd ccls
    $ cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/usr/lib/llvm-14 \
    -DLLVM_INCLUDE_DIR=/usr/lib/llvm-14/include \
    -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-14/
    $ cd Release
    $ sudo make install
    $ cd Release
```
## TODO
Ubuntu setup
- [ ] ble.sh
- [ ] Ubuntu WhiteSur Theme
- [ ] Auto setup bash script
- [ ] Rust Analyzer Setup

Windows setup
- [ ] Auto setup powershell script
- [ ] Rust Analyzer Setup
- [ ] Install ccls

MacOS setup
- [ ] Auto setup shell script
