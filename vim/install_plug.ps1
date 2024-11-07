$originalDirectory = Get-Location
$packpath = "$env:USERPROFILE\vimfiles\pack\plug\start"

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
        vim -u NONE -c "helptags $repoName/doc" -c q
    }
}

Set-Plugin "https://github.com/tpope/vim-fugitive"
Set-Plugin "https://github.com/tpope/vim-vinegar"
Set-Plugin "https://github.com/tpope/vim-commentary"
Set-Plugin "https://github.com/tpope/vim-sleuth"
Set-Plugin "https://github.com/tpope/vim-surround"
Set-Plugin "https://github.com/tpope/vim-unimpaired"
Set-Plugin "https://github.com/tpope/vim-endwise"
Set-Plugin "https://github.com/tpope/vim-eunuch"

cd $originalDirectory
