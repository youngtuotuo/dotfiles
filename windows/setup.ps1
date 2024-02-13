function Ask {
  param(
    [string] $Message
  )

  $response = Read-Host "$Message (Y/n)"
  if ($response -eq "") {
    $response = "n"
  } else {
    $response = $response.ToLower()
  }

  $response -eq "y"
}

if (Ask "============= Do you want to install powershell config? =============") {
	cp $HOME/github/dotfiles/windows/Microsoft.PowerShell_profile.ps1 $PROFILE
}

if (Ask "============= Do you want to install neovim config? =============") {
	New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA/nvim -Target $HOME/github/dotfiles/nvim
}
