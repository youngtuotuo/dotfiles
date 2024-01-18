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

# Go
if ask "============ Do you want to install go? ============"; then
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
fi

# Rust
if ask "============ Do you want to install rust? ============"; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Zig
if ask "============ Do you want to install zig? ============"; then
	read -p "Please give current go tar file url: " resp
	if [ -z "$resp" ]; then
		echo "Empty url, skip."
	else
		wget $resp -O $HOME/zig.tar.xz
		mkdir $HOME/zig
		cd $HOME
		tar xf zig.tar.xz -C zig --strip-components 1
		mv zig/ $HOME/.local/zig
                rm $HOME/zig.tar.xz

	fi
fi

# Lua
if ask "============ Do you want to install lua? ============"; then
	sudo apt install lua5.3
fi

# Bash
if ask "============ Do you want to install .bashrc and .profile? ============"; then
	cp "$(realpath .bashrc)" ~/.bashrc
	cp "$(realpath .profile)" ~/.profile
fi

# Tmux
if ask "============ Do you want to install .tmux.conf? ============"; then
	ln -s "$(realpath ".tmux.conf")" ~/.tmux.conf
fi

# Neovim
if ask "============ Do you want to install neovim? ============"; then
	mkdir $HOME/.local
	git clone https://github.com/neovim/neovim.git $HOME/github/neovim
	cd $HOME/github/neovim
	make distclean
	make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
	make install
fi

# neovim config
if ask "============ Do you want to install nvim config? ============"; then
	mkdir $HOME/.config
	ln -s "$(realpath "nvim")" $HOME/.config/nvim
fi

# fd link
if ask "============ Do you want to link fd to fdfind? ============"; then
	ln -s $(which fdfind) ~/.local/bin/fd
fi

# Case-insensitive bash
# from https://github.com/bartekspitza/dotfiles/blob/master/shell/case_insensitive_completion.sh
# If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc
# so it won't get overriden
if ask "============ Do you want to set case case-insensitive in bash? ============"; then
	if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' >~/.inputrc; fi

	# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
	echo 'set completion-ignore-case On' >>~/.inputrc
fi
