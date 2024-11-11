$repoUrls = @(
    "https://github.com/tpope/vim-fugitive"
    "https://github.com/tpope/vim-vinegar"
    "https://github.com/tpope/vim-commentary"
    "https://github.com/tpope/vim-surround"
    "https://github.com/tpope/vim-unimpaired"
    "https://github.com/tpope/vim-endwise"
    "https://github.com/tpope/vim-eunuch"
    "https://github.com/sheerun/vim-polyglot"
)

$destinationFolder = "$HOME\vimfiles\pack\plug\start"

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
