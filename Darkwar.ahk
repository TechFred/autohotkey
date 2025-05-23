#Persistent
#SingleInstance Force
SetTitleMatchMode, 2

; ===== CONFIG =====
winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
loopCount := 20
clickDelay := 1000            ; 3 seconds
marchDelay := 2.25 * 60 * 1000    ; 2.25 minutes

; ===== MAIN EXECUTION START =====
BlockInput, MouseMove
; Optional: SetTimer, UnlockFailsafe, 60000  ; Uncomment for a failsafe after 1 minute

Loop, %loopCount%
{
    if !WinExist(winTitle) {
        MsgBox, Window not found!
        BlockInput, Off
        ExitApp
    }

    WinActivate, %winTitle%
    WinWaitActive, %winTitle%
	
	Sleep, %clickDelay%
    ; Click Search Lens
    MouseClick, left, 333, 685
    Sleep, %clickDelay%

    ; Click Search Button
    MouseClick, left, 685, 828
    Sleep, %clickDelay%

    ; Click Rally Button
    MouseClick, left, 551, 541
    Sleep, %clickDelay%

    ; Click APC01
    MouseClick, left, 338, 815
    Sleep, %clickDelay%

    ; Click March
    MouseClick, left, 530, 672
    Sleep, %clickDelay%
	
	; Click confirm
    ;MouseClick, left, 	630, 553
    ;Sleep, %clickDelay%

    Sleep, %marchDelay%
}

BlockInput, Off
ExitApp

return  ; End of main execution

; ===== HOTKEY: ESC to exit =====
Esc::
BlockInput, Off
ExitApp

; ===== OPTIONAL FAILSAFE (optional timer unlock) =====
UnlockFailsafe:
BlockInput, Off
SetTimer, UnlockFailsafe, Off
MsgBox, Failsafe: Mouse input unlocked after 60 seconds.
return
