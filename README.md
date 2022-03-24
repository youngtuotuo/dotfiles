## Neovim
<p align="center">
    <img src="pictures/neovimscreenshot.png" />
</p>


## Install Neovim
```bash
    $ sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    $ git clone https://github.com/neovim/neovim.git
    $ cd neovim && sudo make -j8 && sudo make install
```

## Install configuration
```bash
    $ git clone git@github.com:youngtuotuo/dotfiles.git
    $ cd dotfiles && cp ./nvim ~/.confg/
```

## Install Plugin manager
```bash
    $ sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    $ nvim -u NONE
    :Plugsinstall
    :TSInstallSync
```

## Install lsp for python
```bash
    $ pip install 'python-lsp-server[all]'
    $ pip install flake8 black
```

## Install lsp for vimls, bashls, yamlls
```bash
    $ curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    $ sudo apt install nodejs
    $ sudo npm -g install vim-language-server
    $ sudo npm -g install bash-language-server
    $ sudo npm install -g yarn
    $ sudo yarn global add yaml-language-server
```

## Install ccls
Follow [this](https://github.com/MaskRay/ccls/wiki).

