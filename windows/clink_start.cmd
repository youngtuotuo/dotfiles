@echo off
doskey ~=cd /d %USERPROFILE%
doskey wsl_usage=powershell -command "& {Write-Output \"############### WSL Disk Usage ###############\"; Write-Output \"\"; Get-ChildItem \"HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss\" -Recurse | ForEach-Object { if (($_ | Split-Path -Leaf) -ne \"TryStoreWSL\") { $distro_name = ($_ | Get-ItemProperty -Name DistributionName).DistributionName; $distro_dir = ($_ | Get-ItemProperty -Name BasePath).BasePath; $distro_dir = Switch ($PSVersionTable.PSEdition) { \"Core\" { $distro_dir -replace '^\\\\\?\\','' }; \"Desktop\" { if ($distro_dir.StartsWith('\\?\')) { $distro_dir } else { '\\?\' + $distro_dir } } }; Write-Output \"Distribution: $distro_name\"; Write-Output \"Directory: $($distro_dir -replace '\\\\\?\\','')\"; $distro_size = \"{0:N0} MB\" -f ((Get-ChildItem -Recurse -LiteralPath \"$distro_dir\" | Measure-Object -Property Length -sum).sum / 1Mb); Write-Output \"Size: $distro_size\"; Write-Output \"------------------------------\" } } }"
doskey dev="C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -startdir=none -arch=x64 -host_arch=x64
doskey ls=lsd $*       
doskey ll=lsd -Alh $*  
doskey la=lsd -AhF $*  
doskey l=lsd -lF $*    
doskey vi=nvim $*      
doskey less=less -R $* 
doskey alias=doskey /MACROS:ALL
doskey env=set ""
