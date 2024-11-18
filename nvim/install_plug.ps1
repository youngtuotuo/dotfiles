$repoUrls = @(
    "https://github.com/tpope/vim-surround"
    "https://github.com/tpope/vim-fugitive"
    "https://github.com/tpope/vim-vinegar"
    "https://github.com/tpope/vim-unimpaired"
    "https://github.com/sheerun/vim-polyglot"
    "https://github.com/tpope/vim-endwise"
    "https://github.com/tpope/vim-eunuch"
    "https://github.com/ludovicchabant/vim-gutentags"
    "https://github.com/preservim/tagbar"
    "https://github.com/mg979/vim-visual-multi"
    "https://github.com/mbbill/undotree"
    "https://github.com/junegunn/fzf"
    "https://github.com/romainl/vim-qf"
    "https://github.com/junegunn/vim-easy-align"
    "https://github.com/junegunn/vim-peekaboo"
    "https://github.com/iamcco/markdown-preview.nvim"
    "https://github.com/andymass/vim-matchup"
    "https://github.com/wellle/targets.vim"
    "https://github.com/tek256/simple-dark"
)

$destinationFolder = "$env:LOCALAPPDATA\nvim\pack\plug\start"

$jobs = foreach ($url in $repoUrls) {
    Write-Host $url
    Start-Job -ScriptBlock {
        param($url, $destinationFolder)
        git clone $url "$destinationFolder\$([System.IO.Path]::GetFileNameWithoutExtension($url))" 2>$null
    } -ArgumentList $url, $destinationFolder
}

 Wait-Job -Job $jobs
 Receive-Job -Job $jobs
 Remove-Job -Job $jobs
