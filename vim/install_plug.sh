#!/usr/bin/env bash

packpath=$HOME/.vim/pack/plug/start

if [ ! -d $packpath ]; then
    mkdir -p $packpath
fi

cd $packpath

function set_plugin() {
    repo_name=$(basename "$1")
    plugin_dir=$packpath/$repo_name
    if [ ! -d "$plugin_dir" ]; then
        git clone --depth 1 $1
        vim -E -s -u NONE -c "helptags $repo_name/doc" -c q
    fi
}

set_plugin https://github.com/tpope/vim-fugitive &
set_plugin https://github.com/tpope/vim-commentary &
set_plugin https://github.com/tpope/vim-surround &
set_plugin https://github.com/tpope/vim-unimpaired &
set_plugin https://github.com/tpope/vim-endwise &
set_plugin https://github.com/sheerun/vim-polyglot &
set_plugin https://github.com/ludovicchabant/vim-gutentags &
set_plugin https://github.com/preservim/tagbar &
set_plugin https://github.com/mbbill/undotree &
set_plugin https://github.com/junegunn/fzf &
set_plugin https://github.com/junegunn/vim-easy-align &
set_plugin https://github.com/junegunn/vim-peekaboo &
set_plugin https://github.com/iamcco/markdown-preview.nvim &
set_plugin https://github.com/andymass/vim-matchup &
set_plugin https://github.com/tpope/vim-vinegar &
set_plugin https://github.com/pgdouyon/vim-yin-yang &

wait
