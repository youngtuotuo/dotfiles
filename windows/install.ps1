function Show-Usage {
    Write-Host "Usage: ./install.ps1 [options]"
    Write-Host "Options:"
    Write-Host "  vsbuild-tools, policy, scoop, .local, cmake,"
    Write-Host "  powershell, pwsh-config, neovim, nvim-config, python,"
    Write-Host "  zig, fzf, sioyek, wezterm, wezterm-cfg, lua, go, rust,"
    Write-Host "  nodejs, yarn, typst"
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
            winget install --id=Microsoft.VisualStudio.2022.BuildTools  -e
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
            winget install --id=Kitware.CMake  -e
        }
        "powershell" {
            Show-Title "PowerShell"
            winget install --id=Microsoft.PowerShell  -e
        }
        "pwsh-config" {
            Show-Title "PowerShell Config"
            New-Item -ItemType SymbolicLink -Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$HOME\github\dotfiles\windows\Microsoft.PowerShell_profile.ps1"
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
            nvim --headless "+Lazy! sync" +qa
            cd $originalDirectory
        }
        "nvim-config" {
            Show-Title "nvim-config"
            if (-not (Test-Path -Path "$env:LOCALAPPDATA\nvim")) {
                New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$HOME\github\dotfiles\nvim"
            } else {
                Show-Info "$env:LOCALAPPDATA\nvim exists"
            }
            nvim --headless "+Lazy! sync" +qa
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
        "lua" {
            Show-Title "lua"
            scoop install lua
        }
        "go" {
            Show-Title "go"
            scoop install go
        }
        "rust" {
            Show-Title "rust"
            Write-Host "Rust download page: https://www.rust-lang.org/tools/install"
            $url = Read-Host "Please give current rustup exe installer file url"

            if ([string]::IsNullOrWhiteSpace($url)) {
                Show-Info "Empty url, skip."
            } else {
                $rustupExe = "$HOME\rustup.exe"
                Invoke-WebRequest -Uri $url -OutFile $rustupExe
                Start-Process -FilePath $rustupExe
                Remove-Item $rustupExe
            }
        }
        "zig" {
            Show-Title "zig"
            scoop install zig
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
        "fzf" {
            Show-Title "fzf"
            scoop install fzf
        }
        "sioyek" {
            Show-Title "sioyek"
            Write-Host "Sioyek download page: https://github.com/ahrm/sioyek/releases"
            $url = Read-Host "Please give current sioyek zip file url"
            if ([string]::IsNullOrWhiteSpace($url)) {
                Show-Info "Empty url, skip."
            } else {
                $zip = "$HOME\sioyek.zip"
                $extractPath = "$HOME\Downloads\sioyek-release-windows"
                if (-not (Test-Path -Path $extractPath)) {
                    New-Item -ItemType Directory -Path $extractPath
                }
                Invoke-WebRequest -Uri $url -OutFile $zip
                Add-Type -AssemblyName System.IO.Compression.FileSystem
                [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $extractPath)
                $env:Path += ";$extractPath"
                [Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine)
            }
        }
        "wezterm"{
            Show-Title "wezterm"
            Write-Host "Download page: https://wezfurlong.org/wezterm/install/windows.html"
            $url = Read-Host "Please give the url for the wezterm setup.exe"
            $weztermdestination = "$HOME\wezterm_setup.exe"
            Invoke-WebRequest -Uri $url -OutFile $weztermdestination
            Start-Process -FilePath $weztermdestination
            Remove-Item -Path $weztermdestination -Force
        }
        "wezterm-cfg" {
            Show-Title ".wezterm.lua"
            if (-not (Test-Path -Path "$HOME\.wezterm.lua")) {
                New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "$HOME\github\dotfiles\.wezterm.lua"
            } else {
                Show-Info "$HOME\.wezterm.lua exists"
            }
        }
        "nodejs" {
            Show-Title "nodejs"
            scoop install nodejs
        }
        "yarn" {
            Show-Title "yarn"
            npm install -g yarn
        }
        "typst" {
            Show-Title "typst"
            winget install --id Typst.Typst
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

