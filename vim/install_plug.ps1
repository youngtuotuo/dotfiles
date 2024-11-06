$originalDirectory = Get-Location
New-Item -ItemType Directory -Path "$HOME\vimfiles\pack\plug\start" -Force
cd $HOME\vimfiles\pack\plug\start
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/tpope/vim-fugitive }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/tpope/vim-vinegar }
Start-Job -ScriptBlock { git clone --depth 1 https://github.com/tpope/vim-commentary }
cd $originalDirectory
