$originalDirectory = Get-Location
New-Item -ItemType Directory -Path "$HOME\vimfiles\pack\plug\start" -Force
cd $HOME\vimfiles\pack\plug\start
git clone --depth 1 https://github.com/tpope/vim-fugitive
git clone --depth 1 https://github.com/tpope/vim-vinegar
git clone --depth 1 https://github.com/tpope/vim-commentary
cd $originalDirectory
