$originalDirectory = Get-Location
New-Item -ItemType Directory -Path "$env:LOCALAPPDATA\nvim\pack\plug\start" -Force
cd $env:LOCALAPPDATA\nvim\pack\plug\start
# FK PowerScrpts that let async run so complicated, just sequentially clone.
git clone --depth 1 https://github.com/kylechui/nvim-surround
git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter
git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter-textobjects
git clone --depth 1 https://github.com/windwp/nvim-ts-autotag
git clone --depth 1 https://github.com/tpope/vim-fugitive
git clone --depth 1 https://github.com/tpope/vim-vinegar
git clone --depth 1 https://github.com/tpope/vim-sleuth
git clone --depth 1 https://github.com/tpope/vim-unimpaired
cd $originalDirectory
nvim -u NONE `
    -c "helptags nvim-surround/doc" -c "helptags nvim-treesitter/doc" -c "helptags nvim-treesitter-textobjects/doc" `
    -c "helptags vim-fugitive/doc" -c "helptags vim-vinegar/doc" `
    -c "helptags vim-sleuth/doc" -c "helptags vim-unimpaired/doc" -c q
