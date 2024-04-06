@echo off
doskey dev="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" -startdir=none -arch=x64 -host_arch=x64
doskey ls=lsd --color=always --icon=never $*
doskey ll=lsd --color=always --icon=never -Alh $*
doskey la=lsd --color=always --icon=never -AhF $*
doskey l=lsd --color=always --icon=never -lF $*
doskey vi=nvim $*
doskey less=less -R $*
doskey alias=doskey /MACROS:ALL
doskey env=set ""
