$originalDirectory = Get-Location
$packpath = "$env:LOCALAPPDATA\nvim\pack\plug\start"

if (!(Test-Path -Path $packpath)) {
    New-Item -ItemType Directory -Path $packpath -Force | Out-Null
}

cd $packpath

function Set-Plugin {
    param (
        [string]$repoUrl
    )
    
    $repoName = Split-Path -Leaf $repoUrl
    $pluginDir = Join-Path -Path $packpath -ChildPath $repoName
    
    if (!(Test-Path -Path $pluginDir)) {
        git clone --depth 1 $repoUrl
        nvim --headless -u NONE "+helptags $repoName/doc" +qa
    }
}

Set-Plugin "https://github.com/kylechui/nvim-surround"
Set-Plugin "https://github.com/nvim-treesitter/nvim-treesitter"
Set-Plugin "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
Set-Plugin "https://github.com/tpope/vim-fugitive"
Set-Plugin "https://github.com/tpope/vim-vinegar"
Set-Plugin "https://github.com/tpope/vim-sleuth"
Set-Plugin "https://github.com/tpope/vim-unimpaired"
Set-Plugin "https://github.com/tpope/vim-endwise"
Set-Plugin "https://github.com/tpope/vim-eunuch"

cd $originalDirectory
