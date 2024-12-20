#!/usr/bin/env bash

function usage() {
	echo "Usage: ./install.sh [options]"
	echo "Options:"
	echo "  .local, homebrew, .zshrc, neovim, nvim-config"
	echo "  rust, zig, tmux, tmux-config, lua, go, python"
	echo "  fzf, ruby, fd, .vimrc, .wezterm.lua"
}

if [ $# -eq 0 ]; then
	usage
fi

function info() {
	echo -e "\033[93mINFO\033[0m $1"
}

function title() {
	echo "========== $1 =========="
}

function install_target() {
	case "$1" in
	".local")
		title ".local"
		if [ ! -d "$HOME/.local" ]; then
			mkdir -p $HOME/.local
		else
			info "$HOME/.local exists"
		fi
		if [ ! -d "$HOME/.local/bin" ]; then
			mkdir -p $HOME/.local/bin
		else
			info "$HOME/.local/bin exists"
		fi
		if [ ! -d "$HOME/.local/share" ]; then
			mkdir -p $HOME/.local/share
		else
			info "$HOME/.local/share exists"
		fi
		if [ ! -d "$HOME/.local/man" ]; then
			mkdir -p $HOME/.local/man
		else
			info "$HOME/.local/man exists"
		fi
		;;
	"homebrew")
		title "homebrew"
		if ! command -v brew >/dev/null; then
			/bin/bash -c "$(curl --location --fail --silent --show-error https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			eval "$($(which brew) shellenv)"
		else
			info "brew exists: $(which brew)"
		fi
		;;
	"go")
		title "go"
		if ! command -v go >/dev/null; then
			brew install go
		else
			info "go exists: $(which go)"
		fi
		;;
	"python")
		title "python"
		echo "Python download page: https://www.python.org/downloads/"
		read -p "Please give current python tar file url: " resp
		if [ -z "$resp" ]; then
			info "Empty url, skip."
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
			tar xf $HOME/python.tgz -C python --strip-components 1
			cd python
			./configure --prefix=$HOME/.local --enable-optimizations --with-openssl=$(brew --prefix openssl) --with-ensurepip=install ARCHFLAGS="-arch arm64" LDFLAGS="-L$HOME/.local/lib" CPPFLAGS="-I$HOME/.local/include"
			make
			make install
		fi
		;;
	"rust")
		title "rust"
		if ! command -v rustup >/dev/null; then
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		else
			info "rustup exists: $(which rustup)"
		fi
		;;
	"zig")
		title "zig"
		echo "Zig download page: https://ziglang.org/download/"
		read -p "Please give current zig tar file url: " resp
		if [ -z "$resp" ]; then
			info "Empty url, skip."
		else
			if [ -f "$HOME/zig.tar.xz" ]; then
				rm $HOME/zig.tar.xz
			fi
			if [ -d "$HOME/zig" ]; then
				rm -r $HOME/zig
			fi
			wget $resp -O $HOME/zig.tar.xz
			mkdir -p $HOME/zig
			tar xf $HOME/zig.tar.xz -C $HOME/zig --strip-components 1
			if [ -d "$HOME/.local/zig" ]; then
				rm -r $HOME/.local/zig
			fi
			mv $HOME/zig/ $HOME/.local/zig
			rm $HOME/zig.tar.xz
		fi
		;;
	"vim")
		title "vim"
		if [ ! -d "$HOME/github/vim" ]; then
			git clone --depth 1 https://github.com/vim/vim $HOME/github/vim
		fi
		cd $HOME/github/vim
		git pull
		make distclean
		./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --enable-python3interp=yes --enable-perlinterp=yes --enable-luainterp=yes --enable-cscope --prefix=$HOME/.local
		make
		make install
		;;
	"neovim")
		title "neovim"
		if [ ! -d "$HOME/github/neovim" ]; then
			git clone https://github.com/neovim/neovim.git $HOME/github/neovim
		fi
		cd $HOME/github/neovim
		git pull
		make distclean
		make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
		make install
		;;
	"nvim-config")
		title "nvim-config"
		mkdir -p $HOME/.config
		if [ ! -d "%HOME/.config/nvim" ]; then
			mkdir -p $HOME/.config
			ln -s $HOME/github/dotfiles/nvim $HOME/.config/nvim
		else
			info "$HOME/.config/nvim exists"
		fi
		echo ""
		;;
	"fzf")
		title "fzf"
		if ! command -v fzf >/dev/null; then
			brew install fzf
		else
			info "fzf exists: $(which fzf)"
		fi
		;;
	"clang")
		title "clang"
		if ! command -v clang >/dev/null; then
			brew install llvm
		else
			info "clang exists: $(which clang)"
		fi
		;;
	"tmux")
		title "tmux"
		if ! command -v tmux >/dev/null; then
			brew install tmux
		else
			info "tmux exists: $(which tmux)"
		fi
		;;
	"tmux-config")
		title "tmux-config"
		ln -s $HOME/github/dotfiles/.tmux.conf ~/.tmux.conf
		;;
	"fd")
		title "fd"
		if ! command -v fd >/dev/null; then
			brew install fd
		else
			info "fd exists: $(which fd)"
		fi
		;;
	"nodejs")
		title "nodejs"
		if ! command -v node >/dev/null; then
			brew install nodej
		else
			info "node exists: $(which node)"
		fi
		;;
	"typst")
		title "typst"
		brew install typst
		;;
	"yarn")
		title "yarn"
		if ! command -v yarn >/dev/null; then
			brew install yarn
		else
			info "yarn exists: $(which yarn)"
		fi
		;;
	"ruby")
		title "ruby"
		if ! command -v ruby >/dev/null; then
			brew install chruby ruby-install xz
			ruby-install ruby 3.1.3
		else
			info "ruby exists: $(which ruby)"
		fi
		;;
	".vimrc")
		title ".vimrc"
		cp $HOME/github/dotfiles/mac/.vimrc ~/.vimrc
		;;
	".wezterm.lua")
		title ".wezterm.lua"
		ln -s $HOME/github/dotfiles/mac/.wezterm.lua ~/.wezterm.lua
		;;
	".zshrc")
		title ".zshrc"
		ln -s $HOME/github/dotfiles/mac/.zshrc ~/.zshrc
		;;
	".zprofile")
		title ".zprofile"
		ln -s $HOME/github/dotfiles/mac/.zprofile ~/.zprofile
		;;
	"-h" | "--help" | "help")
		usage
		;;
	*)
		unknown+=($1)
		;;
	esac
}

unknown=()
for arg in "$@"; do
	install_target "$arg"
done
if [ ! ${#unknown[@]} -eq 0 ]; then
	info "Unknown option: ${unknown[*]}"
fi
exit 0
