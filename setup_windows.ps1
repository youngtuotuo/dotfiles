Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
winget install -e --id Git.Git
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name PSFzf -Scope CurrentUser -Force
scoop install curl sudo gcc clang neovim-nightly fzf
scoop bucket add main
scoop install main/llvm main/nodejs main/yarn
cp $env:USERPROFILE/github/dotfiles/Microsoft.PowerShell_profile.ps1 $env:USERPROFILE/Documents/PowerShell/


