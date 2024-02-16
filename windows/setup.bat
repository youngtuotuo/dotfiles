@echo off

setlocal enabledelayedexpansion

:clink
echo.============ Do you want to install clink? ========== (Y/n):
set /p response=
if "!response!"=="" (
  set response=n
)
set response=!response:~0,1!
if "!response!"=="Y" goto clink_install
if "!response!"=="y" goto clink_install
goto alias

:clink_install
scoop install clink
clink autorun install
clink inject
cp %USERPROFILE%\github\dotfiles\windows\oh-my-posh.lua %=clink.profile%
cp %USERPROFILE%\github\dotfiles\windows\clink_start.cmd %=clink.profile%
goto end

:end
endlocal
