; Heal - Click
; Image : Assets\Darkwars_hospital\heal.png
; Region -> 
; Client:	652, 596 (default)
; Client:	688, 614 (default)



; Alliance Help - Click
; Image : Assets\Darkwars_hospital\alliance_help.png
; Region -> 
; Client:	605, 590 (default)
; Client:	743, 650 (default)


;Speedup - Wait
; Image : Assets\Darkwars_hospital\speedup.png
; Region -> 
; Client:	605, 590 (default)
; Client:	743, 650 (default)

; Once speedup image is gone, go back to Heal. Loop indifinitly



#Persistent
winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
CoordMode, Pixel, Client
CoordMode, Mouse, Client
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2 ; So you can match part of the window title if needed

; Define image regions (x1, y1, x2, y2)
;healRegion := [652, 596, 688, 614]
;healRegion := [500, 500, 800, 800]
;allianceHelpRegion := [500, 500, 800, 800]
;speedupRegion := [500, 500, 800, 800]

; Fullscreen [1166, 667, 1362, 770]
;1166, 667
;Client:	1362, 770 (default)

healRegion := [0, 0, 1950, 1024]
allianceHelpRegion := [0, 0, 1950, 1024]


Loop
{
    ; Activate the game window
    IfWinExist, %winTitle%
    {
		WinActivate, %winTitle%
		WinWaitActive, %winTitle%
		
        ; 2. Click Heal
		x1 := healRegion[1]
		y1 := healRegion[2]
		x2 := healRegion[3]
		y2 := healRegion[4]
        ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\heal.jpg
        if (ErrorLevel = 0)
        {
            MouseClick, left, %xH%, %yH%
            Sleep, 500
			MouseMove, 300, 300
		}
		;MsgBox % Errorlevel

        ; 3. Click Alliance Help
        ImageSearch, xA, yA, % allianceHelpRegion[1], % allianceHelpRegion[2], % allianceHelpRegion[3], % allianceHelpRegion[4], *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\alliance_help.jpg
        if (ErrorLevel = 0)
        {
            MouseClick, left, %xA%, %yA%
            Sleep, 500
			MouseMove, 300, 300
        }
		;MsgBox % Errorlevel
		;MouseMove, 300, 300
    }
	MouseMove, 300, 300
    Sleep, 1000
	MouseMove, 500, 500
}


; ===== HOTKEY: ESC to exit =====
Esc::
BlockInput, Off
ExitApp