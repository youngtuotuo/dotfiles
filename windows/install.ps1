function Show-Usage {
		Write-Host "Usage: ./install.ps1 [options]"
		Write-Host "Options:"
		Write-Host "  vsbuild-tools, policy, scoop, .local, cmake"
		Write-Host "  powershell, neovim, python, zig"
}

if ($args.Count -eq 0) {
		Show-Usage
		exit
}

function Show-Info($message) {
		Write-Host "INFO: $message" -ForegroundColor Yellow
}

function Show-Note($message) {
		Write-Host "Note: $message" -ForegroundColor Red
}

function Show-Title($message) {
		Write-Host "========== $message =========="
}

function Install-Target($target) {
		switch ($target) {
				"vsbuild-tools" {
						Show-Title "Build Tools for Visual Studio"
						winget install --id=Microsoft.VisualStudio.2022.BuildTools -e
				}
				"policy" {
						Show-Title "policy"
						Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
				}
				"scoop" {
						Show-Title "scoop"
						Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
				}
				".local" {
						Show-Title ".local"
						mkdir $env:USERPROFILE\.local
						[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\Users\User\.local\bin", 'User')
				}
				"cmake" {
						Show-Title "cmake"
						winget install --id=Kitware.CMake -e
				}
				"powershell" {
						Show-Title "PowerShell"
						winget install --id=Microsoft.PowerShell -e
				}
				"neovim" {
						Show-Title "neovim"
						if (-not (Test-Path -Path "$HOME\github\neovim")) {
								git clone https://github.com/neovim/neovim.git $HOME\github\neovim
						}
						$originalDirectory = Get-Location
						cd $HOME\github\neovim
						git pull
						dev amd64
						cmake --build .deps --target clean
						cmake --build build --target clean
						cmake -S cmake.deps -B .deps -G Ninja -D CMAKE_BUILD_TYPE=Release
						cmake --build .deps --config Release
						cmake -B build -G Ninja -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=$env:USERPROFILE\.local
						cmake --build build --config Release --target install
						cd $originalDirectory
				}
				"python" {
						Show-Title "python"
						Write-Host "Python download page: https://www.python.org/downloads/"
						$url = Read-Host "Please give current python exe installer file url"

						if ([string]::IsNullOrWhiteSpace($url)) {
								Show-Info "Empty url, skip."
						} else {
								$pythonExe = "$HOME\python.exe"
								Invoke-WebRequest -Uri $url -OutFile $pythonExe
								Start-Process -FilePath $pythonExe
								Remove-Item $pythonExe
						}
				}
				"git-credential-manager" {
						Show-Title "git-credential-manager"
						Write-Host "GCM download page: https://github.com/git-ecosystem/git-credential-manager/releases"
						$url = Read-Host "Please give current gcm exe installer file url"
						if ([string]::IsNullOrWhiteSpace($url)) {
								Show-Info "Empty url, skip."
						} else {
								$gcmExe = "$HOME\gcm.exe"
								Invoke-WebRequest -Uri $url -OutFile $gcmExe
								Start-Process -FilePath $gcmExe
								Remove-Item $gcmExe
						}
				}
				default {
						Show-Usage
						exit
				}
		}
}

foreach ($target in $args) {
		Install-Target $target
}

