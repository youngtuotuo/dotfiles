$originalDirectory = Get-Location
New-Item -ItemType Directory -Path "$HOME\AppData\Local\nvim\pack\plug\start" -Force
cd $HOME\AppData\Local\nvim\pack\plug\start
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/kylechui/nvim-surround }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter-textobjects }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/windwp/nvim-ts-autotag }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/chrisgrieser/nvim-various-textobjs }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/tpope/vim-fugitive }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/tpope/vim-vinegar }
cd $originalDirectory
