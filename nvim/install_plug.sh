#!/usr/bin/env bash

plugins=(
	"https://github.com/iamcco/markdown-preview.nvim"
	"https://github.com/junegunn/fzf"
	"https://github.com/junegunn/vim-easy-align"
	"https://github.com/kaarmu/typst.vim"
	"https://github.com/mbbill/undotree"
	"https://github.com/sheerun/vim-polyglot"
	"https://github.com/tommcdo/vim-exchange"
	"https://github.com/tpope/vim-commentary"
	"https://github.com/tpope/vim-endwise"
	"https://github.com/tpope/vim-fugitive"
	"https://github.com/tpope/vim-rsi"
	"https://github.com/tpope/vim-surround"
	"https://github.com/tpope/vim-unimpaired"
	"https://github.com/tpope/vim-vinegar"
	"https://github.com/wellle/targets.vim"
)
packpath=$HOME/.config/nvim/pack/plug/start

if [ ! -d $packpath ]; then
	mkdir -p $packpath
fi

cd $packpath

function set_plugin() {
	repo_name=$(basename "$1")
	plugin_dir=$packpath/$repo_name
	if [ ! -d "$plugin_dir" ]; then
		git clone --depth 1 $1
		if [ -d "$repo_name/doc" ]; then
			nvim --headless -u NONE "+helptags $repo_name/doc" +qa
		fi
	fi
}

for url in "${plugins[@]}"; do
	set_plugin "$url" &
done
wait
