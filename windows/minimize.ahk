#NoEnv
SendMode Input

#m::WinMinimize, A
#If WinActive("ahk_exe discord.exe")
^w::
  WinClose
return