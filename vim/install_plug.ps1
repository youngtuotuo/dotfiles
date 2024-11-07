$originalDirectory = Get-Location
New-Item -ItemType Directory -Path "$HOME\vimfiles\pack\plug\start" -Force
cd $HOME\vimfiles\pack\plug\start
git clone --depth 1 https://github.com/tpope/vim-fugitive
git clone --depth 1 https://github.com/tpope/vim-vinegar
git clone --depth 1 https://github.com/tpope/vim-commentary
git clone --depth 1 https://github.com/tpope/vim-sleuth
git clone --depth 1 https://github.com/tpope/vim-surround
git clone --depth 1 https://github.com/tpope/vim-unimpaired
cd $originalDirectory
vim -u NONE -c "helptags vim-fugitive/doc" -c "helptags vim-vinegar/doc" -c "helptags vim-commentary/doc" `
    -c "helptags vim-sleuth/doc" -c "helptags vim-surround/doc" -c "helptags vim-unimpaired/doc" -c q
