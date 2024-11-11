#!/usr/bin/env bash

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

set_plugin https://github.com/tpope/vim-surround &
set_plugin https://github.com/tpope/vim-fugitive &
set_plugin https://github.com/tpope/vim-vinegar &
set_plugin https://github.com/sheerun/vim-polyglot &
set_plugin https://github.com/tpope/vim-endwise &
set_plugin https://github.com/tpope/vim-eunuch &

wait
