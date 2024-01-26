#!/usr/bin/env /usr/bin/bash

# Ask Y/n
function ask() {
	read -p "$1 (Y/n): " resp
	if [ -z "$resp" ]; then
		response_lc="y" # empty is Yes
	else
		response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
	fi

	[ "$response_lc" = "y" ]
}

# python
if ask "============ Do you want to install another python? ============"; then
	read -p "Please give current python tar file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		wget $resp -O $HOME/python.tgz
		mkdir -p $HOME/python
		cd $HOME
		tar xf python.tgz -C python --strip-components 1
		cd python
		./configure --prefix=$HOME/.local --enable-optimizations
		make
		make install
	fi
fi

# pip
if ask "============ Do you want to install another pip? ============"; then
	wget https://bootstrap.pypa.io/get-pip.py -O $HOME/get-pip.py
	cd $HOME
        python3 get-pip.py

fi

# lua
if ask "============ Do you want to install another lua? ============"; then
	if ! command -v lua >/dev/null; then
		read -p "Please give current lua tar file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			wget $resp -O $HOME/lua.tar.gz
			mkdir -p $HOME/lua
			cd $HOME
			tar zxf lua.tar.gz -C lua --strip-components 1
			cd lua
			sed -i "s/INSTALL_TOP= \/usr\/local/INSTALL_TOP= $\(HOME\)\/\.local/" Makefile
			make all test
			make install
		fi
	else
		echo -e "\033[93mINFO\033[0m lua exists: $(which lua)"
	fi
fi

# Go
if ask "============ Do you want to install go? ============"; then
	if ! command -v go >/dev/null; then
		read -p "Please give current go tar file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			wget $resp -O $HOME/go.tar.xz
			cd $HOME
			tar xf go.tar.xz
			mv go/ $HOME/.local/go
			rm $HOME/go.tar.xz
		fi
	else
		echo -e "\033[93mINFO\033[0m go exists: $(which go)"
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
	if ! command -v zig >/dev/null; then
		read -p "Please give current zig tar file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			wget $resp -O $HOME/zig.tar.xz
			mkdir -p $HOME/zig
			cd $HOME
			tar xf zig.tar.xz -C zig --strip-components 1
			mv zig/ $HOME/.local/zig
			rm $HOME/zig.tar.xz
		fi
	else
		echo -e "\033[93mINFO\033[0m zig exists: $(which zig)"
	fi
fi

# Bash
if ask "============ Do you want to install .bashrc and .profile? ============"; then
	ln -s $HOME/github/dotfiles/ubuntu/.bashrc ~/.bashrc
	ln -s $HOME/github/dotfiles/ubuntu/.profile ~/.profile
fi

# Neovim
if ask "============ Do you want to install neovim? ============"; then
	if ! command -v nvim >/dev/null; then
		mkdir -p $HOME/.local
		git clone https://github.com/neovim/neovim.git $HOME/github/neovim
		cd $HOME/github/neovim
		make distclean
		make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
		make install
		rm $HOME/.local/lib/nvim/parser/*.so
	else
		echo -e "\033[93mINFO\033[0m nvim exists: $(which nvim)"
	fi
fi

# neovim config
if ask "============ Do you want to install nvim config? ============"; then
	mkdir -p $HOME/.config
	ln -s $HOME/github/dotfiles/nvim $HOME/.config/nvim
fi

# fd link
if ask "============ Do you want to link fd to fdfind? ============"; then
	ln -s $(which fdfind) ~/.local/bin/fd
fi

# fzf
if ask "============ Do you want to install fzf? ============"; then
	if ! command -v fzf >/dev/null; then
		git clone https://github.com/junegunn/fzf.git $HOME/github/fzf
		cd $HOME/github
		./fzf/install
	else
		echo -e "\033[93mINFO\033[0m fzf exists: $(which fzf)"
	fi
fi

# Case-insensitive bash
# from https://github.com/bartekspitza/dotfiles/blob/master/shell/case_insensitive_completion.sh
if ask "============ Do you want to set case case-insensitive in bash? ============"; then
	if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' >~/.inputrc; fi
	# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
	echo 'set completion-ignore-case On' >>~/.inputrc
fi

# wsl.conf file
if ask "============ Do you want to install wsl.conf? ============"; then
	cd $HOME/github
	cp ./windows/wsl.conf /etc/wsl.conf
fi

# git credential manager
if ask "============ Do you want to install gcm? ============"; then
	if ! command -v git-credential-manager >/dev/null; then
		read -p "Please give current gcm deb file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			wget $resp -O $HOME/gcm.deb
			sudo dpkg -i $HOME/gcm.deb
			git-credential-manager configure
			git config --global credential.credentialStore cache
		fi
	else
		echo -e "\033[93mINFO\033[0m git-credential-manager exists: $(which git-credential-manager)"
	fi
fi

# tmux
if ask "============ Do you want to install tmux? ============"; then
	if ! command -v tmux >/dev/null; then
		git clone https://github.com/tmux/tmux.git $HOME/github/tmux
		cd $HOME/github/tmux
		sh autogen.sh
		./configure --prefix=$HOME/.local
		make
		make install
	else
		echo -e "\033[93mINFO\033[0m tmux exists: $(which tmux)"
	fi
fi

# tmux config
if ask "============ Do you want to install .tmux.conf? ============"; then
	ln -s $HOME/github/dotfiles/.tmux.conf ~/.tmux.conf
fi

# vimrc
if ask "============ Do you want to install .vimrc? ============"; then
	ln -s $HOME/github/dotfiles/.vimrc ~/.vimrc
fi

# wezterm
if ask "============ Do you want to install .wezterm.lua? ============"; then
	ln -s $HOME/github/dotfiles/.wezterm.lua ~/.wezterm.lua
fi