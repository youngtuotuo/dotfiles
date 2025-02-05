#!/usr/bin/env bash

function usage() {
	echo "Usage: ./install.sh [options]"
	echo "Options:"
	echo "  .local, homebrew"
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
			ese
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
