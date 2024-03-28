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
goto end


:clink_install
scoop install clink
clink autorun install
cp %USERPROFILE%\github\dotfiles\windows\clink_start.cmd %=clink.profile%
clink installscripts %USERPROFILE%\github\dotfiles\windows\clink_scripts
clink set tilde.autoexpand true
clink set autosuggest.enable false
goto latex

:latex
echo.============ Do you want to install latex? ========== (Y/n):
set /p response=
if "!response!"=="" (
  set response=n
)
set response=!response:~0,1!
if "!response!"=="Y" goto latex_install
if "!response!"=="y" goto latex_install
goto end

:latex_install
scoop install latex
echo Please use miktex console to install latexmk
goto end

:end
endlocal
