Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource None
Set-PSReadLineKeyHandler -Chord Ctrl+Alt+h -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -Colors @{
  Command            = 'White'
  Number             = 'White'
  Member             = 'White'
  Operator           = 'White'
  Type               = 'White'
  Variable           = 'White'
  Parameter          = 'White'
  ContinuationPrompt = 'White'
  Default            = 'White'
}

function dev($name) {
    $curDir = Get-Location;
    C:\'Program Files (x86)\Microsoft Visual Studio'\2022\BuildTools\Common7\Tools\Launch-VsDevShell.ps1 -Arch $name;
    cd $curDir
}

function wsl_usage($name) {
    Write-Output "############### WSL Disk Usage ###############"
    Write-Output ""
    Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" -Recurse |
    ForEach-Object {
        if (($_ | Split-Path -Leaf) -ne "TryStoreWSL") {
            $distro_name = ($_ | Get-ItemProperty -Name DistributionName).DistributionName
            $distro_dir =  ($_ | Get-ItemProperty -Name BasePath).BasePath
            $distro_dir = Switch ($PSVersionTable.PSEdition) {
              "Core" {
                $distro_dir -replace '^\\\\\?\\',''
              }
              "Desktop" {
                if ($distro_dir.StartsWith('\\?\')) {
                    $distro_dir
                } else {
                    '\\?\' + $distro_dir
                }
              }
            }
            Write-Output "Distribution: $distro_name"
            Write-Output "Directory: $($distro_dir -replace '\\\\\?\\','')"
            $distro_size = "{0:N0} MB" -f ((Get-ChildItem -Recurse -LiteralPath "$distro_dir" | Measure-Object -Property Length -sum).sum / 1Mb)
            Write-Output "Size: $distro_size"
            Write-Output "------------------------------"
        }
    }
}

function wsl_cleanup($name) {
    Write-Output "Please run the following commands"
    Write-Output "wsl --shutdown"
    Write-Output "diskpart"
    Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" -Recurse |
    ForEach-Object {
        if (($_ | Split-Path -Leaf) -ne "TryStoreWSL") {
            $distro_name = ($_ | Get-ItemProperty -Name DistributionName).DistributionName
            $distro_dir =  ($_ | Get-ItemProperty -Name BasePath).BasePath
            $distro_dir = Switch ($PSVersionTable.PSEdition) {
              "Core" {
                $distro_dir -replace '^\\\\\?\\',''
              }
              "Desktop" {
                if ($distro_dir.StartsWith('\\?\')) {
                    $distro_dir
                } else {
                    '\\?\' + $distro_dir
                }
              }
            }
            Write-Output "select vdisk file=$($distro_dir -replace '\\\\\?\\','')\ext4.vhdx"
        }
    }
    Write-Output "attach vdisk readonly"
    Write-Output "compact vdisk"
    Write-Output "detach vdisk"
    Write-Output "exit"
}
