$originalDirectory = Get-Location
$packpath = "$env:USERPROFILE\vimfiles\pack\plug\start"

if (!(Test-Path -Path $packpath)) {
    New-Item -ItemType Directory -Path $packpath -Force | Out-Null
}

cd $packpath

function Set-Plugin {
    param (
        [string]$RepoUrl
    )

    $RepoName = [System.IO.Path]::GetFileNameWithoutExtension($RepoUrl)
    $PluginDir = Join-Path -Path $packpath -ChildPath $RepoName

    if (-not (Test-Path -Path $PluginDir)) {
        Start-Job -ScriptBlock {
            param ($RepoUrl, $RepoName)
            git clone --depth 1 $RepoUrl
            $DocPath = Join-Path -Path $RepoName -ChildPath "doc"
            if (Test-Path -Path $DocPath) {
                nvim --headless -u NONE "+helptags $DocPath" +qa
            }
        } -ArgumentList $RepoUrl, $RepoName
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

Get-Job | Wait-Job | Receive-Job

cd $originalDirectory
