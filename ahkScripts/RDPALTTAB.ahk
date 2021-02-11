#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#persistent
#Tab::WinTabbing()
return

WinTabbing() {
    WinGetTitle, Title, A                             ; Get Title
    StringRight, TitleEnd, Title, 25                  ; RDC is 25 letters long
    If (TitleEnd = "Remote Desktop Connection")       ; Check that an RDC is active. This will probably have
                                                      ; issues with the inital "connect to dialog of RDC
    {
        Send, {Alt down}{PgDn}                        ; Press and hold alt, and press pgdn
        Hotkey, Enter, Entering, On                   ; Map Enter, Click, and their alt-counterparts to Entering()
        Hotkey, !Enter, Entering, On
        Hotkey, LButton, Entering, On
        Hotkey, !LButton, Entering, On
        return
    }
}
; There is no return statement at the end of this function, because we want
; Control Tab to work when focused in any other window.

; I tried to map Tab/Alt Tab (because alt is still pressed) to Right arrow
; and Control Tab/Control Alt Tab to left arrow. I was unable to get it to work.
; I left the functions in comments if anyone want to try    
; Righting()
;   Send, Right
;   return
; }

; Lefting() {
;   Send, Right
;   return
; }

Entering() {
    Send, {Alt}{Enter}                                ; Releases Alt, and makes the selection
    Hotkey, Enter, Entering, Off                      ; See WinTabbing()
    Hotkey, !Enter, Entering, Off
    Hotkey, LButton, Entering, Off
    Hotkey, !LButton, Entering, Off
    return
}