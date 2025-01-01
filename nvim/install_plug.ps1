$repoUrls = @(
		"https://github.com/iamcco/markdown-preview.nvim"
		"https://github.com/junegunn/fzf"
		"https://github.com/junegunn/vim-easy-align"
		"https://github.com/kaarmu/typst.vim"
		"https://github.com/mbbill/undotree"
		"https://github.com/mzlogin/vim-markdown-toc"
		"https://github.com/sheerun/vim-polyglot"
		"https://github.com/tommcdo/vim-exchange"
		"https://github.com/tpope/vim-abolish"
		"https://github.com/tpope/vim-commentary"
		"https://github.com/tpope/vim-endwise"
		"https://github.com/tpope/vim-fugitive"
		"https://github.com/tpope/vim-repeat"
		"https://github.com/tpope/vim-rsi"
		"https://github.com/tpope/vim-surround"
		"https://github.com/tpope/vim-unimpaired"
		"https://github.com/tpope/vim-vinegar"
		"https://github.com/tpope/vim-vividchalk"
		"https://github.com/wellle/targets.vim"
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
