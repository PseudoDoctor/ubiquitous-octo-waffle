;Geen's Quambit - YouTube - Google Chrome
;ahk_class Chrome_WidgetWin_1
;ahk_exe chrome.exe
;ahk_pid 58640
$XButton2:: ;Mouse4 (Forward)
  KeyWait, Enter
  While !GetKeyState("Enter","P")
    ControlSend [{Enter}, Desa]
  KeyWait, Enter
Return
