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

# Bash
if ask "============ Do you want to install .bashrc and .profile? ============"; then
	cp "$(realpath .bashrc)" ~/.bashrc
	cp "$(realpath .profile)" ~/.profile
fi

# Tmux conf
if ask "============ Do you want to install .tmux.conf? ============"; then
	ln -s "$(realpath ".tmux.conf")" ~/.tmux.conf
fi

# Install neovim
if ask "============ Do you want to install neovim? ============"; then
	mkdir $HOME/.local
	git clone https://github.com/neovim/neovim.git ~/github/neovim
	cd ~/github/neovim
	make distclean
	make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
	make install
fi

# neovim conf
if ask "============ Do you want to install nvim config? ============"; then
	mkdir $HOME/.config
	ln -s "$(realpath "nvim")" $HOME/.config/nvim
fi

# fd conf
if ask "============ Do you want to link fd to fdfind? ============"; then
	ln -s $(which fdfind) ~/.local/bin/fd
fi

# from https://github.com/bartekspitza/dotfiles/blob/master/shell/case_insensitive_completion.sh
# If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc
# so it won't get overriden
if ask "============ Do you want to set case case-insensitive in bash? ============"; then
	if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' >~/.inputrc; fi

	# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
	echo 'set completion-ignore-case On' >>~/.inputrc
fi
