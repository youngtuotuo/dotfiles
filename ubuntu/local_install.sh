#!/usr/bin/env /usr/bin/bash

# Ask Y/n
function ask() {
	read -p "$1 (Y/n): " resp
	if [ -z "$resp" ]; then
		response_lc="n" # empty is No
	else
		response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
	fi

	[ "$response_lc" = "y" ]
}

# .local
if ask "============ Do you want to create ~/.local? ============"; then
	if [ ! -d "$HOME/.local" ]; then
		mkdir -p $HOME/.local
	else
		echo -e "\033[93mINFO\033[0m $HOME/.local exists"
	fi
fi

# Neovim
if ask "============ Do you want to install neovim? ============"; then
	if [ ! -d "$HOME/github/neovim"]; then
		git clone https://github.com/neovim/neovim.git $HOME/github/neovim
	fi
	cd $HOME/github/neovim
	git pull
	make distclean
	make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
	make install
fi

# python
if ask "============ Do you want to install python? ============"; then
	echo "Python download page: https://www.python.org/downloads/"
	read -p "Please give current python tar file url: " resp
	if [ -z "$resp" ]; then
		echo -e "\033[93mINFO\033[0m Empty url, skip."
	else
		if [ -f "$HOME/python.tgz" ]; then
			rm $HOME/python.tgz
		fi
		if [ -d "$HOME/python" ]; then
			rm -r $HOME/python
		fi
		wget $resp -O $HOME/python.tgz
		mkdir -p $HOME/python
		cd $HOME
		tar xf python.tgz -C python --strip-components 1
		cd python
		./configure --prefix=$HOME/.local --enable-optimizations --enable-shared LDFLAGS="-Wl,--rpath=${HOME}/.local/lib"
		make
		make install
	fi
fi

# pip
if ask "============ Do you want to install pip? ============"; then
	wget https://bootstrap.pypa.io/get-pip.py -O $HOME/get-pip.py
	cd $HOME
	python3 get-pip.py
fi

# lua
if ask "============ Do you want to install lua? ============"; then
	echo "Lua download page: https://www.lua.org/download.html"
	read -p "Please give current lua tar file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		if [ -f "$HOME/lua.tar.gz" ]; then
			rm $HOME/lua.tar.gz
		fi
		if [ -d "$HOME/lua" ]; then
			rm -r $HOME/lua
		fi
		wget $resp -O $HOME/lua.tar.gz
		mkdir -p $HOME/lua
		cd $HOME
		tar zxf lua.tar.gz -C lua --strip-components 1
		cd lua
		sed -i "s/INSTALL_TOP= \/usr\/local/INSTALL_TOP= $\(HOME\)\/\.local/" Makefile
		make all test
		make install
	fi
fi

# Go
if ask "============ Do you want to install go? ============"; then
	echo "Go install page: https://go.dev/dl/"
	read -p "Please give current go tar file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		if [ -f "$HOME/go.tar.gz" ]; then
			rm $HOME/go.tar.gz
		fi
		if [ -d "$HOME/go" ]; then
			rm -r $HOME/go
		fi
		wget $resp -O $HOME/go.tar.xz
		cd $HOME
		tar xf go.tar.xz
		mv go/ $HOME/.local/go
	fi
fi

# Rust
if ask "============ Do you want to install rust? ============"; then
	if ! command -v rustup >/dev/null; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	else
		echo -e "\033[93mINFO\033[0m rustup exists: $(which rustup)"
	fi
fi

# Zig
if ask "============ Do you want to install zig? ============"; then
	echo "Zig download page: https://ziglang.org/download/"
	read -p "Please give current zig tar file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		if [ -f "$HOME/zig.tar.gz" ]; then
			rm $HOME/zig.tar.gz
		fi
		if [ -d "$HOME/zig" ]; then
			rm -r $HOME/zig
		fi
		wget $resp -O $HOME/zig.tar.xz
		mkdir -p $HOME/zig
		cd $HOME
		tar xf zig.tar.xz -C zig --strip-components 1
		mv zig/ $HOME/.local/zig
	fi
fi

# gdb
if ask "============ Do you want to install gdb? ============"; then
	echo "gdb download page: https://ftp.gnu.org/gnu/gdb/"
	read -p "Please give current gdb tar file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		if [ -f "$HOME/gdb.tar.gz" ]; then
			rm $HOME/gdb.tar.gz
		fi
		if [ -d "$HOME/gdb" ]; then
			rm -r $HOME/gdb
		fi
		wget $resp -O $HOME/gdb.tar.gz
		mkdir -p $HOME/gdb
		cd $HOME
		tar zxf gdb.tar.gz -C gdb --strip-components 1
		cd gdb
		./configure --prefix=$HOME/.local
		make
		make install
	fi
fi

# git credential manager
if ask "============ Do you want to install git-credential-manager? ============"; then
	echo "gcm download url: https://github.com/git-ecosystem/git-credential-manager/releases"
	read -p "Please give current gcm deb file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		if [ -f "$HOME/gcm.deb" ]; then
			rm $HOME/gcm.deb
		fi
		wget $resp -O $HOME/gcm.deb
		sudo dpkg -i $HOME/gcm.deb
		git-credential-manager configure
		git config --global credential.credentialStore cache
	fi
fi

# tmux
if ask "============ Do you want to install tmux? ============"; then
    if [ ! -d "$HOME/github/tmux" ]; then
        git clone https://github.com/tmux/tmux.git $HOME/github/tmux
    fi
	cd $HOME/github/tmux
    git pull
	sh autogen.sh
	./configure --prefix=$HOME/.local
	make
	make install
fi

# cmake
if ask "============ Do you want to install cmake? ============"; then
	echo "cmake download page: https://cmake.org/download/"
	read -p "Please give current cmake zip file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		if [ -f "$HOME/cmake.tar.gz" ]; then
			rm $HOME/cmake.tar.gz
		fi
		if [ -d "$HOME/cmake" ]; then
			rm -r $HOME/cmake
		fi
		wget $resp -O $HOME/cmake.tar.gz
		mkdir -p $HOME/cmake
		cd $HOME
		tar zxf -j cmake.tar.gz -C cmake --strip-components 1
		cp $HOME/cmake/bin/* $HOME/.local/bin/
		cp -r $HOME/cmake/share/* $HOME/.local/share/
		cp -r $HOME/cmake/man/* $HOME/.local/man/
	fi
fi

# nvtop
if ask "============ Do you want to install nvtop? ============"; then
    echo "nvtop download page: https://github.com/Syllo/nvtop/releases"
    read -p "Please give current nvtop app image url: " resp
    if [ -z "$resp" ]; then
        echo "Empty url, skip."
    else
        wget $resp -O $HOME/nvtop
        cp $HOME/nvtop $HOME/.local/bin/
    fi
fi

# watchman
if ask "============ Do you want to install watchman? ============"; then
    echo "watchman download page: https://github.com/facebook/watchman/releases"
    read -p "Please give current watchman zip file url: " resp
    if [ -z "$resp" ]; then
        echo "Empty url, skip."
    else
		if [ -f "$HOME/watchman.zip" ]; then
			rm $HOME/watchman.zip
		fi
		if [ -d "$HOME/watchman" ]; then
			rm -r $HOME/watchman
		fi
        wget $resp -O $HOME/watchman.zip
        mkdir -p $HOME/watchman
        cd $HOME
        unzip -d $HOME/watchman -j watchman.zip
        cp $HOME/watchman/lib/* $HOME/.local/lib
        cp $HOME/watchman/watchman/* $HOME/.local/bin
    fi
fi

# oh-my-posh
if ask "============ Do you want to install oh-my-posh? ============"; then
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/.local/bin
    mkdir -p $HOME/.local/omp
    wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/robbyrussell.omp.json -P $HOME/.local/omp
fi

# ruby
if ask "============ Do you want to install ruby? ============"; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    rbenv install -l
    read -p "Please select desired version: " resp
    if [ -z "$resp" ]; then
        echo "Empty version, skip."
    else
        rbenv install $resp
        rbenv global $resp
        gem install jekyll bundler
    fi
fi

# mojo
if ask "============ Do you want to install mojo? ============"; then
    curl https://get.modular.com | sh -
    modular auth
    modular install mojo
    modular install max
    MAX_PATH=$(modular config max.path) && python3 -m pip install --find-links $MAX_PATH/wheels max-engine
fi
