Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
winget install -e --id Git.Git
scoop install curl wget sudo gcc grep lsd which touch less findutils llvm nodejs yarn pkg-config coreutils
cp $HOME/github/dotfiles/windows/Microsoft.PowerShell_profile.ps1 $PROFILE
New-Item -ItemType SymbolicLink -Path $HOME/AppData/Local/nvim $HOME/github/dotfiles/nvim
scoop install clink
