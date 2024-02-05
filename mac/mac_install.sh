#!/usr/bin/env bash

function ask() {
	read -p "$1 (Y/n): " resp
	if [ -z "$resp" ]; then
		response_lc="n" # empty is No
	else
		response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
	fi

	[ "$response_lc" = "y" ]
}

# homebrew
if ask "============ Do you want to install homebrew ============"; then
	if ! command -v brew >/dev/null; then
		/bin/bash -c "$(curl --location --fail --silent --show-error https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		eval "$($(which brew) shellenv)"
	else
		echo -e "\033[93mINFO\033[0m brew exists: $(which brew)"
	fi
fi

# go
if ask "============ Do you want to install go ============"; then
	if ! command -v go >/dev/null; then
		brew install go
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
		brew install zig
	else
		echo -e "\033[93mINFO\033[0m zig exists: $(which zig)"
	fi
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
		rm $HOME/.local/nvim/parser/*
	else
		echo -e "\033[93mINFO\033[0m nvim exists: $(which nvim)"
	fi
fi

# neovim config
if ask "============ Do you want to install nvim config? ============"; then
	mkdir -p $HOME/.config
	ln -s $HOME/github/dotfiles/nvim $HOME/.config/nvim
fi

# fzf
if ask "============ Do you want to install fzf? ============"; then
	if ! command -v fzf >/dev/null; then
		brew install fzf
	else
		echo -e "\033[93mINFO\033[0m fzf exists: $(which fzf)"
	fi
fi

# clang
if ask "============ Do you want to install clang? ============"; then
	if ! command -v clang >/dev/null; then
		brew install llvm
	else
		echo -e "\033[93mINFO\033[0m clang exists: $(which clang)"
	fi
fi

# tmux
if ask "============ Do you want to install tmux? ============"; then
	if ! command -v tmux >/dev/null; then
		brew install tmux
	else
		echo -e "\033[93mINFO\033[0m tmux exists: $(which tmux)"
	fi
fi

# tmux config
if ask "============ Do you want to install .tmux.conf? ============"; then
	ln -s $HOME/github/dotfiles/.tmux.conf ~/.tmux.conf
fi

# fd
if ask "============ Do you want to install fd ============"; then
	if ! command -v fd >/dev/null; then
		brew install fd
	else
		echo -e "\033[93mINFO\033[0m fd exists: $(which fd)"
	fi
fi

# nodejs
if ask "============ Do you want to install nodejs? ============"; then
	if ! command -v node >/dev/null; then
		brew install nodej
	else
		echo -e "\033[93mINFO\033[0m node exists: $(which node)"
	fi
fi

# watchman
if ask "============ Do you want to install watchman? ============"; then
	if ! command -v watchman >/dev/null; then
		brew install watchman
	else
		echo -e "\033[93mINFO\033[0m watchman exists: $(which watchman)"
	fi
fi

# yarn
if ask "============ Do you want to install yarn? ============"; then
	if ! command -v yarn >/dev/null; then
		brew install yarn
	else
		echo -e "\033[93mINFO\033[0m yarn exists: $(which yarn)"
	fi
fi

# git credential manager
if ask "============ Do you want to install gcm? ============"; then
	brew install --cask git-credential-manager
fi

# vimrc
if ask "============ Do you want to install .vimrc? ============"; then
	ln -s $HOME/github/dotfiles/.vimrc ~/.vimrc
fi

# wezterm
if ask "============ Do you want to install .wezterm.lua? ============"; then
	ln -s $HOME/github/dotfiles/.wezterm.lua ~/.wezterm.lua
fi

# zshrc
if ask "============ Do you want to install .zshrc? ============"; then
	ln -s $HOME/github/dotfiles/mac/.zshrc ~/.zshrc
fi

# zprofile
if ask "============ Do you want to install .zprofile? ============"; then
	ln -s $HOME/github/dotfiles/mac/.zprofile ~/.zprofile
fi
