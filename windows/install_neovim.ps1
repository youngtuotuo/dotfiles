function Show-Usage {
    Write-Host "Usage: ./install.ps1 [options]"
    Write-Host "Options:"
    Write-Host "  .local, cmake, .bashrc, neovim, nvim-config, python, lua, go,"
    Write-Host "  rust, zig, gdb, git-credential-manager, tmux, tmux-config, nvtop,"
    Write-Host "  fzf, ruby, mojo, fd, sioyek, uv, case-insensitive-bash, wsl.conf,"
    Write-Host "  .vimrc, .wezterm.lua, dependencies, nodejs, yarn, cuda, tigervnc"
}

if ($args.Count -eq 0) {
    Show-Uage
    exit
}

# cd $HOME\github\neovim
# git pull
# dev amd64
# cmake --build .deps --target clean
# cmake --build build --target clean
# cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release
# cmake --build .deps --config Release
# cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=$env:USERPROFILE\.local
# cmake --build build --config Release --target install
