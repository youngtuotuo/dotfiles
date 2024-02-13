Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord Ctrl+Alt+h -Function BackwardKillWord
Set-PSReadLineOption -Colors @{ InlinePrediction = "$([char]0x1b)[38;5;238m" }

Set-Alias vi nvim
Set-Alias ls lsd
function ll($name) { lsd -Alh $name}
function la($name) { lsd -AhF $name}
function l($name) { lsd -lF $name}
function pkill($name) { get-process $name -ErrorAction SilentlyContinue | stop-process }
function reboot {
	shutdown /r /t 0
}

function dev($name) {
    $curDir = Get-Location;
    C:\'Program Files\Microsoft Visual Studio'\2022\Community\Common7\Tools\Launch-VsDevShell.ps1 -Arch $name;
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

function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
}
oh-my-posh init pwsh --config 'C:/Users/User/AppData/Local/Programs/oh-my-posh/themes/robbyrussell.omp.json' | Invoke-Expression
