Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" -Recurse |
ForEach-Object {
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
    Write-Output "------------------------------"
    Write-Output "Distribution: $distro_name"
    Write-Output "Directory: $($distro_dir -replace '\\\\\?\\','')"
    $distro_size = "{0:N0} MB" -f ((Get-ChildItem -Recurse -LiteralPath "$distro_dir" | Measure-Object -Property Length -sum).sum / 1Mb)
    Write-Output "Size: $distro_size"
}
