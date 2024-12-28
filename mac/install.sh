#!/usr/bin/env bash

function usage() {
		echo "Usage: ./install.sh [options]"
		echo "Options:"
		echo "  .local, homebrew, python, zig, vim, neovim"
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
		install_target "$arg" &
done
if [ ! ${#unknown[@]} -eq 0 ]; then
		info "Unknown option: ${unknown[*]}"
fi
exit 0
