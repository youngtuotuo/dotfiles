#!/usr/bin/env /usr/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install zstd ninja-build gettext libtool libtool-bin autoconf \
	automake cmake g++ pkg-config unzip curl doxygen build-essential \
	clang libevent-dev ncurses-dev bison git fd ripgrep -y

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor |
	sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" |
	sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

echo "============== Go =============="
tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz

echo "============== Rust =============="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "============== Zig =============="
snap install zig --classic --beta
