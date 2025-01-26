function Show-Usage {
		Write-Host "Usage: ./install.ps1 [options]"
		Write-Host "Options:"
		Write-Host "  vsbuild-tools, policy, scoop, .local, cmake"
		Write-Host "  powershell, python"
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
				default {
						Show-Usage
						exit
				}
		}
}

foreach ($target in $args) {
		Install-Target $target
}

