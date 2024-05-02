#!/usr/bin/env /usr/bin/bash

function usage() {
	echo "Usage: ./local_install.sh [options]"
	echo "Options:"
	echo "  .local, cmake, .bashrc, neovim, nvim-config, python, lua, go,"
	echo "  rust, zig, gdb, git-credential-manager, tmux, tmux-config, nvtop,"
	echo "  fzf, ruby, mojo, fd, sioyek, uv, case-insensitive-bash, wsl.conf,"
	echo "  .vimrc, .wezterm.lua"
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
	"cmake")
		title "cmake"
		echo "cmake download page: https://cmake.org/download/"
		read -p "Please give current cmake binary distribution tar file url: " resp
		if [ -z "$resp" ]; then
			info "Empty url, skip."
		else
			if [ -f "$HOME/cmake.tar.gz" ]; then
				rm $HOME/cmake.tar.gz
			fi
			if [ -d "$HOME/cmake" ]; then
				rm -r $HOME/cmake
			fi
			wget $resp -O $HOME/cmake.tar.gz
			mkdir -p $HOME/cmake
			tar -zxf $HOME/cmake.tar.gz -C $HOME/cmake --strip-components 1
			cp $HOME/cmake/bin/* $HOME/.local/bin/
			cp -r $HOME/cmake/share/* $HOME/.local/share/
			cp -r $HOME/cmake/man/* $HOME/.local/man/
			rm $HOME/cmake.tar.gz
			rm -r $HOME/cmake
		fi
		;;
	".bashrc")
		title ".bashrc and .profile"
		cp $HOME/github/dotfiles/ubuntu/.bashrc ~/.bashrc
		cp $HOME/github/dotfiles/ubuntu/.profile ~/.profile
		info "Please reload the bash"
		exit 0
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
		if [ ! -d "%HOME/.config/nvim" ]; then
			mkdir -p $HOME/.config
			ln -s $HOME/github/dotfiles/nvim $HOME/.config/nvim
		else
			info "$HOME/.config/nvim exists"
		fi
		nvim --headless "+Lazy! sync" +qa
		echo ""
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
			tar xf $HOME/python.tgz -C $HOME/python --strip-components 1
			cd $HOME/python
			./configure --prefix=$HOME/.local --enable-optimizations --with-ensurepip=install --enable-shared LDFLAGS="-Wl,--rpath=${HOME}/.local/lib"
			make
			make install
			ln -s $HOME/.local/bin/python3 $HOME/.local/bin/python
			ln -s $HOME/.local/bin/pip3 $HOME/.local/bin/pip
			rm $HOME/python.tgz
			rm -r $HOME/python
		fi
		;;
	"lua")
		title "lua"
		echo "Lua download page: https://www.lua.org/download.html"
		read -p "Please give current lua tar file url: " resp
		if [ -z "$resp" ]; then
			info "Empty url, skip."
		else
			if [ -f "$HOME/lua.tar.gz" ]; then
				rm $HOME/lua.tar.gz
			fi
			if [ -d "$HOME/lua" ]; then
				rm -r $HOME/lua
			fi
			wget $resp -O $HOME/lua.tar.gz
			mkdir -p $HOME/lua
			tar zxf $HOME/lua.tar.gz -C $HOME/lua --strip-components 1
			cd $HOME/lua
			sed -i "s/INSTALL_TOP= \/usr\/local/INSTALL_TOP= $\(HOME\)\/\.local/" Makefile
			make all test
			make install
			rm -r $HOME/lua
			rm $HOME/lua.tar.gz
		fi
		;;
	"go")
		title "go"
		echo "Go install page: https://go.dev/dl/"
		read -p "Please give current go tar file url: " resp
		if [ -z "$resp" ]; then
			info "Empty url, skip."
		else
			if [ -f "$HOME/go.tar.gz" ]; then
				rm $HOME/go.tar.gz
			fi
			if [ -d "$HOME/go" ]; then
				rm -r $HOME/go
			fi
			if [ -d "$HOME/.local/go" ]; then
				rm -r $HOME/.local/go
			fi
			wget $resp -O $HOME/go.tar.xz
			tar xf $HOME/go.tar.xz
			mv $HOME/go/ $HOME/.local/go
			rm $HOME/go.tar.xz
		fi
		;;
	"rust")
		title "rust"
		if ! command -v rustup >/dev/null; then
			cd $HOME/
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		else
			echo -e "\033[93mINFO\033[0m rustup exists: $(which rustup)"
		fi
		;;
	"zig")
		title "zig"
		echo "Zig download page: https://ziglang.org/download/"
		read -p "Please give current zig tar file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			if [ -f "$HOME/zig.tar.xz" ]; then
				rm $HOME/zig.tar.xz
			fi
			if [ -d "$HOME/zig" ]; then
				rm -r $HOME/zig
			fi
			wget $resp -O $HOME/zig.tar.xz
			mkdir -p $HOME/zig
			tar xf zig.tar.xz -C $HOME/zig --strip-components 1
			if [ -d "$HOME/.local/zig" ]; then
				rm -r $HOME/.local/zig
			fi
			mv $HOME/zig/ $HOME/.local/zig
			rm $HOME/zig.tar.xz
		fi
		;;
	"gdb")
		title "gdb"
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
			tar zxf $HOME/gdb.tar.gz -C $HOME/gdb --strip-components 1
			cd $HOME/gdb
			./configure --prefix=$HOME/.local
			make
			make install
			rm $HOME/gdb.tar.gz
			rm -r $HOME/gdb
		fi
		;;
	"git-credential-manager")
		title "git-credential-manager"
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
			rm $HOME/gcm.deb
		fi
		;;
	"tmux")
		title "tmux"
		if [ ! -d "$HOME/github/tmux" ]; then
			git clone https://github.com/tmux/tmux.git $HOME/github/tmux
		fi
		cd $HOME/github/tmux
		git pull
		sh autogen.sh
		./configure --prefix=$HOME/.local
		make
		make install
		;;
	"tmux-config")
		title "tmux-config"
		ln -s $HOME/github/dotfiles/.tmux.conf ~/.tmux.conf
		;;
	"nvtop")
		title "nvtop"
		echo "nvtop download page: https://github.com/Syllo/nvtop/releases"
		read -p "Please give current nvtop app image url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			wget $resp -O $HOME/nvtop
			mv $HOME/nvtop $HOME/.local/bin/
		fi
		;;
	"fzf")
		title "fzf"
		if [ ! -d "$HOME/.fzf" ]; then
			mkdir $HOME/.fzf
		fi
		if [ -d "$HOME/.fzf" ]; then
			git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		else
			git -C ~/.fzf pull
		fi
		~/.fzf/install
		;;
	"ruby")
		title "ruby"
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
		;;
	"mojo")
		title "mojo"
		curl https://get.modular.com | sh -
		modular auth
		modular install mojo
		# modular install max
		# MAX_PATH=$(modular config max.path) && python3 -m pip install --find-links $MAX_PATH/wheels max-engine
		;;
	"fd")
		title "fd"
		echo "fd download url: https://github.com/sharkdp/fd/releases"
		read -p "Please give current fd deb file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			if [ -f "$HOME/fd.deb" ]; then
				rm $HOME/fd.deb
			fi
			wget $resp -O $HOME/fd.deb
			sudo dpkg -i $HOME/fd.deb
			ln -s $(which fdfind) $HOME/.local/bin/fd
			rm $HOME/fd.deb
		fi
		;;
	"sioyek")
		title "sioyek"
		echo "sioyek download url: https://github.com/ahrm/sioyek/releases"
		read -p "Please give current sioyek zip file url: " resp
		if [ -z "$resp" ]; then
			echo "Empty url, skip."
		else
			if [ -f "$HOME/sioyek.zip" ]; then
				rm $HOME/sioyek.zip
			fi
			wget $resp -O $HOME/sioyek.zip
			unzip $HOME/sioyek.zip
			mv $HOME/Sioyek-x86_64.AppImage $HOME/.local/bin/sioyek
			mv $HOME/Sioyek-x86_64.AppImage.config $HOME/.local/bin/
			rm $HOME/sioyek.zip
		fi
		;;
	"uv")
		title "uv"
		curl -LsSf https://astral.sh/uv/install.sh | sh
		;;
	"case-insensitive-bash")
		title "case-insensitive-bash"
		if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' >~/.inputrc; fi
		# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
		echo 'set completion-ignore-case On' >>~/.inputrc
		;;
	"wsl.conf")
		title "wsl.conf"
		cp $HOME/github/dotfiles/windows/wsl.conf /etc/wsl.conf
		;;
	".vimrc")
		title ".vimrc"
		ln -s $HOME/github/dotfiles/.vimrc ~/.vimrc
		;;
	".wezterm.lua")
		title ".wezterm.lua"
		ln -s $HOME/github/dotfiles/.wezterm.lua ~/.wezterm.lua
		;;
	"-h" | "--help" | "help" | *)
		usage
		;;
	esac
}

for arg in "$@"; do
	install_target "$arg"
done
exit 0
