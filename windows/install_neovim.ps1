cd $HOME\github\neovim
git pull
dev amd64
cmake --build .deps --target clean
cmake --build build --target clean
cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release
cmake --build .deps --config Release
cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=$env:USERPROFILE\.local
cmake --build build --config Release --target install
