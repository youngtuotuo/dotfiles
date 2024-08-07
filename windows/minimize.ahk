SendMode Input

!m::WinMinimize, A

~RButton::
MouseClick, right
KeyWait, RButton

#If WinActive("ahk_exe discord.exe")
^w::
  WinClose
return

#If WinActive("ahk_exe Messenger.exe")
^w::
  WinClose
return