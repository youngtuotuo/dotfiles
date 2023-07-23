# Dotfiles

This repo includes:
* Tools I use for data science development in ubuntu/mac/windows.
* Tools config files.
* Url or Installation scripts that hard to find by simply google once.

<p align="center">
    <img src="pictures/mac.png"/>
</p>
<p align="center">
    <img src="pictures/win.png"/>
</p>


# Easy Install Tools
Tools listed here can be found by goolge once.<br>
Fira Code Nerd Font, Clipboard Inidicator, RayCast, OpenVPN Client, Stats, AltTab, Rectangle, Zsh, zsh-autosuggestions, miniconda

# Other Configs
## Miniconda disalbe prompt
```bash
conda config --system --set env_prompt ""
```
## Cuda
[reference](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)

```bash
sudo apt-get install linux-headers-$(uname -r)
# WARNING: the `ubuntu2004/x86_64` in the following url may be different, remember to change it.
# you can find the feasible choices here https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#network-repo-installation-for-ubuntu
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo apt-get install cuda -y
```

## Neovim
  
Ubuntu
```bash
# Install Dependicies
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y

# Build from Source
git clone https://github.com/neovim/neovim.git
cd neovim
sudo make -j$(nproc) CMAKE_BUILD_TYPE=Release && sudo make CMAKE_BUILD_TYPE=Release install
```

Mac (homebrew + build from source)
  
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install ninja cmake gettext curl
cd neovim
make distclean
make CMAKE_BUILD_TYPE=Release
sudo make CMAKE_BUILD_TYPE=Release install
export PATH=~/github/neovimm/build/bin:$PATH
```
Install Config for Neovim
  
```bash
mkdir ~/github
git clone git@github.com:youngtuotuo/dotfiles.git ~/github/dotfiles
ln -s ~/github/dotfiles/nvim/ ~/.config/nvim
```
Pyright Related Configuration
[Configuration](https://github.com/microsoft/pyright/blob/main/docs/configuration.md)

## Latex Compiler

```bash
sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texlive-xetex latexmk -y
```

## Solve cv2 typing issue with Pyright

By adding the `__init__.pyi` file, you'll get suggestion from Pyright.<br>
```bash
cd ~/github/dotfiles
cp cv2/__init__.pyi $VIRTUAL_ENV/lib/python3.8/site-packages/cv2/__init__.pyi
```

## tigerVNC

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

## noVNC

```bash
git clone https://github.com/novnc/noVNC ~/github/noVNC
pip install numpy
./utils/novnc_proxy --vnc <host>:5902
```
