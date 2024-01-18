#!/bin/bash

# Ask Y/n
function ask() {
    read -p "$1 (Y/n): " resp
    if [ -z "$resp" ]; then
        response_lc="y" # empty is Yes
    else
        response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
    fi

    [ "$response_lc" = "y" ]
}

# TODO: auto update, go, rust, zig, lua, nodejs, npm, yarn, gcm, clang,

# Bash
if ask "Do you want to install .bashrc and .profile?"; then
    cp "$(realpath .bashrc)" ~/.bashrc
    cp "$(realpath .profile)" ~/.profile
fi


# Tmux conf
if ask "Do you want to install .tmux.conf?"; then
    ln -s "$(realpath ".tmux.conf")" ~/.tmux.conf
fi

# neovim conf
if ask "Do you want to install nvim config?"; then
    ln -s "$(realpath "nvim")" ~/.config/nvim
fi
