#!/usr/bin/env bash

function usage() {
	echo "Usage: ./install.sh [options]"
	echo "Options:"
	echo "  .local, cmake, python, tigervnc"
}

if [ $# -eq 0 ]; then
	usage
fi

function info() {
	echo -e "\033[93mINFO\033[0m $1"
}

function note() {
	echo -e "\033[91mNote\033[0m $1"
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
			fi
			;;
		"tigervnc")
			title "tigervnc"
			sudo apt install tigervnc-standalone-server
			mkdir $HOME/.vnc
			cp $HOME/github/dotfiles/xstartup $HOME/.vnc/xstartup
			sudo chmod +x ~/.vnc/xstartup
			;;
		"-h" | "--help" | "help" | "")
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
