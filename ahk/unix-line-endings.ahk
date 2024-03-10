#Requires AutoHotkey v2

; ==== DEVELOPMENT SHORTCUTS ====
; #+r:: {
;   Reload
; }
; #+t:: {
;   aID := WinGetID("A")
;   wclass := WinGetClass(aID)
;   wtitle := WinGetTitle(aID)

;   MsgBox(
;     "ID:  " aID "`n"
;     "class:  " wclass "`n"
;     "title:  " wtitle "`n"
;   )
; }

; uncomment for conditional shortcut
; #HotIf WinActive("alacritty")

^+v::
{
    A_Clipboard := StrReplace(A_Clipboard, "`r`n", "`n")
    Send("^+v")
}

; uncomment for conditional shortcut
; #HotIf
