@echo off
DOSKEY ls=lsd $*
DOSKEY ll=lsd -Alh $*
DOSKEY la=lsd -AhF $*
DOSKEY l=lsd -lF $*
DOSKEY vi=nvim $*
DOSKEY less=less -R $*
DOSKEY cd=if "$1" equ "~" ( cd /d %USERPROFILE% ) ELSE if "$1" equ " " ( cd /d %USERPROFILE% ) ELSE if "$1" equ "" ( cd /d %USERPROFILE% ) ELSE ( cd $* )
DOSKEY dev="C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -startdir=none -arch=x64 -host_arch=x64
DOSKEY wsl_usage=powershell -command "& {Write-Output \"############### WSL Disk Usage ###############\"; Write-Output \"\"; Get-ChildItem \"HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss\" -Recurse | ForEach-Object { if (($_ | Split-Path -Leaf) -ne \"TryStoreWSL\") { $distro_name = ($_ | Get-ItemProperty -Name DistributionName).DistributionName; $distro_dir = ($_ | Get-ItemProperty -Name BasePath).BasePath; $distro_dir = Switch ($PSVersionTable.PSEdition) { \"Core\" { $distro_dir -replace '^\\\\\?\\','' }; \"Desktop\" { if ($distro_dir.StartsWith('\\?\')) { $distro_dir } else { '\\?\' + $distro_dir } } }; Write-Output \"Distribution: $distro_name\"; Write-Output \"Directory: $($distro_dir -replace '\\\\\?\\','')\"; $distro_size = \"{0:N0} MB\" -f ((Get-ChildItem -Recurse -LiteralPath \"$distro_dir\" | Measure-Object -Property Length -sum).sum / 1Mb); Write-Output \"Size: $distro_size\"; Write-Output \"------------------------------\" } } }"
