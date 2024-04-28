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

# neovim config
if ask "============ Do you want to install nvim config? ============"; then
	if [ ! -d "%HOME/.config/nvim" ]; then
		mkdir -p $HOME/.config
		ln -s $HOME/github/dotfiles/nvim $HOME/.config/nvim
	else
		echo -e "\033[93mINFO\033[0m $HOME/.config/nvim exists"
	fi
fi

# Bash
if ask "============ Do you want to install .bashrc and .profile? ============"; then
	ln -s $HOME/github/dotfiles/ubuntu/.bashrc ~/.bashrc
	ln -s $HOME/github/dotfiles/ubuntu/.profile ~/.profile
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
