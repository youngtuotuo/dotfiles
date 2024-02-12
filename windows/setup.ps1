Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
winget install -e --id Git.Git
scoop install curl wget sudo gcc grep lsd which touch ln less findutils llvm nodejs yarn
cp $HOME/github/dotfiles/windows/Microsoft.PowerShell_profile.ps1 $HOME/Documents/PowerShell/
New-Item -ItemType SymbolicLink -Path $HOME/AppData/Local/nvim $HOME/github/dotfiles/nvim
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
