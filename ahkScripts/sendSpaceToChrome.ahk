#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#KeyHistory 100
#InstallKeybdHook

;a::ControlSend, ahk_parent, {b}, ahk_exe chrome.exe
F7::ControlSend, ahk_parent, {m}, ahk_exe chrome.exe
Volume_Down::ControlSend, ahk_parent, {Down}, ahk_exe chrome.exe
Volume_Up::ControlSend, ahk_parent, {Up}, ahk_exe chrome.exe
F6::ControlSend, ahk_parent, {Space}, ahk_exe chrome.exe
Media_Prev::ControlSend, ahk_parent, {j}, ahk_class Chrome_RenderWidgetHostHWND1 YouTube
Media_Next::ControlSend, ahk_parent, {k}, ahk_class Chrome_RenderWidgetHostHWND1 YouTube