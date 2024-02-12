Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
winget install -e --id Git.Git
scoop install curl wget sudo gcc grep lsd which touch ln less findutils llvm nodejs yarn

