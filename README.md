# Dotfiles
My routine data science envrionment set up in ubuntu/mac/windows.<br>

<p align="center">
    <img src="pictures/image.png"/>
</p>


#### Neovim Shortcut
1. select python code and press `\p` -> execute the selected codes
2. press `\p`  -> execute current whole python file
3. press `\g+` -> compile current cpp code and execute the binary (vimpp.out)
4. press `\gc` -> compile current c code and execute the binary (vimc.out)
6. press `\ss` -> toggle line numbers and relative line numbers
7. press `\ts` -> toggle treesitter highlight

#### Tmux Shortcut
1. `<c-b>>` move current window right
2. `<c-b><` move current window right
3. `<c-b>\` horizontal split
3. `<c-b>|` vertical split



# Mac/Linux Installation

<details>
    <summary><font size="4"><b>&nbsp;Warp, RayCast, Obsidian, noVNC, tigerVNC, OpenVPN Connect, VLC, Stats, AltTab, Rectangle</b></font></summary>

    TBD
</details>

<details>
    <summary><font size="4"><b>&nbsp;Gnome-Tweaks and Dconf-Editor</b></font></summary>

```bash
# Use `Tweaks` app to change caps to ctrl.
sudo apt install gnome-tweaks -y
# Use `dconf-editor` to change click app action be 'minimize-and-preview'. (org/gnome/shell/extensions/dash-to-dock/click-action)
sudo apt install dconf-editor -y
# (Optional) Disable laptop keybard
xinput disable "AT Translated Set 2 keyboard"
```
</details>

<details>
    <summary><font size="4"><b>&nbsp;Tmux theme</b></font></summary>

```bash
git clone https://github.com/odedlaz/tmux-onedark-theme ~/github/
ln -s ~/github/dotfiles/.tmux.conf ~/.tmux.conf
```
</details>



<details>
    <summary><font size="4"><b>&nbsp;Clipboard Indicator</b></font></summary>

Ubuntu

[https://extensions.gnome.org/extension/779/clipboard-indicator/](https://extensions.gnome.org/extension/779/clipboard-indicator/)

Mac

[https://apps.apple.com/us/app/copyclip-clipboard-history/id595191960?mt=12](https://apps.apple.com/us/app/copyclip-clipboard-history/id595191960?mt=12)
</details>

<details>
    <summary><font size="4"><b>&nbsp;Fira Code Nerd Font</b></font></summary>
    
[https://github.com/ryanoasis/nerd-fonts/releases](https://github.com/ryanoasis/nerd-fonts/releases)
</details>

<details>
    <summary><font size="4"><b>&nbsp;Docker and CVAT</b></font></summary>

[https://opencv.github.io/cvat/docs/administration/basics/installation/](https://opencv.github.io/cvat/docs/administration/basics/installation/)
</details>

<details>
    <summary><font size="4"><b>&nbsp;Git-Credential-Manager</b></font></summary>

[https://github.com/GitCredentialManager/git-credential-manager/releases](https://github.com/GitCredentialManager/git-credential-manager/releases)
```bash
sudo dpkg -i <path-to-package>
git-credential-manager configure
```
</details>

<details>
    <summary><font size="4"><b>&nbsp;Cuda</b></font></summary>

[https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)<br>

```bash
sudo apt-get install linux-headers-$(uname -r)
# WARNING: the `ubuntu2004/x86_64` in the following url may be different, remember to change it.
# you can find the feasible choices here https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#network-repo-installation-for-ubuntu
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo apt-get install cuda -y
```
</details>

<details>
  <summary><font size="4"><b>&nbsp;Neovim</b></font></summary>
  
Ubuntu
```bash
# Install Dependicies
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y

# Build from Source
git clone https://github.com/neovim/neovim.git
cd neovim
sudo make -j$(nproc) CMAKE_BUILD_TYPE=Release && sudo make CMAKE_BUILD_TYPE=Release install
```

Mac (homebrew)
  
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --HEAD neovim
```
  
Both
```bash
# Install Plugin Manager
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install Configuration
git clone git@github.com:youngtuotuo/dotfiles.git ~/github/dotfiles
ln -s ~/github/dotfiles/nvim/ ~/.config/nvim

# Run the following command to install LSP, formatter, etc.
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
</details>

<details>
  <summary><font size="4"><b>&nbsp;Latex Compiler</b></font></summary>

```bash
sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texlive-xetex latexmk -y
```
</details>

<details>
    <summary><font size="4"><b>&nbsp;Zathura PDF viewer for VimTex</b></font></summary>

```bash
sudo apt install zathura -y
```
</details>

<details>
    <summary><font size="4"><b>&nbsp;Rust (cargo, rustup)</b></font></summary>

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```
</details>

<details>
    <summary><font size="4"><b>&nbsp;Alacritty</b></font></summary>

[https://github.com/alacritty/alacritty/blob/master/INSTALL.md](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)
</details>

<details>
    <summary><font size="4"><b>&nbsp;Solve cv2 typing issue with Pyright</b></font></summary>

`opencv-python` or `opencv-contrib-python` is unable to be resolved by Pyright. By adding the `__init__.pyi` file, you'll get suggestion from Pyright.<br>
```bash
cd ~/github/dotfiles
cp cv2/__init__.pyi $VIRTUAL_ENV/lib/python3.8/site-packages/cv2/__init__.pyi
```
</details>

# Windows Installation

<details>
    <summary><font size="4"><b>&nbsp;Scoop</b></font></summary>

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex

```
</details>


<details>
    <summary><font size="4"><b>&nbsp;Neovim</b></font></summary>

```powershell
# TODO: Other commands
scoop install neovim
```
</details>


## TODO
Ubuntu/Mac setup
- [ ] Auto setup shell script
