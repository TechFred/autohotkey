#Persistent
winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
CoordMode, Pixel, Client
CoordMode, Mouse, Client
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2 ; So you can match part of the window title if needed


BlockInput, MouseMove
loopCount := 30
count := 0

; Define image regions (x1, y1, x2, y2)
;healRegion := [652, 596, 688, 614]
;healRegion := [500, 500, 800, 800]
;allianceHelpRegion := [500, 500, 800, 800]
;speedupRegion := [500, 500, 800, 800]

; Fullscreen [1166, 667, 1362, 770]
;1166, 667
;Client:	1362, 770 (default)

AllRegion := [0, 0, 1950, 1024]
allianceHelpRegion := [0, 0, 1950, 1024]
lens_region := [837, 770, 893, 810]


Loop
{
    ; Activate the game window
    IfWinExist, %winTitle%
	
	; Maximize the window
	WinMaximize, %winTitle%
    {
		WinActivate, %winTitle%
		WinWaitActive, %winTitle%
		
		
		x1 := AllRegion[1]
		y1 := AllRegion[2]
		x2 := AllRegion[3]
		y2 := AllRegion[4]
		; Click search
        ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\help.jpg
        if (ErrorLevel = 0)
        {
            MouseClick, left, %xH%, %yH%
            Sleep, 1000
		}
		
		ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\cancel.bmp
		if (ErrorLevel = 0)
		{
			MouseClick, left, %xH%, %yH%
			Sleep, 2000
		}
		
    
		x1 := lens_region[1]
		y1 := lens_region[2]
		x2 := lens_region[3]
		y2 := lens_region[4]
		; Click lens (859, 791)
		; FAEDED 4 x 8 -> 853, 800 to 859, 803
		;MouseClick, left, 859, 791
		;Sleep, 1000
		
		PixelSearch, xH, yH, 853, 800, 859, 803, 0xDEDEFA, 25, 0
        ;ImageSearch, xH, yH, x1, y1, x2, y2, *TransBlack *200 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\lens.bmp 
        if (ErrorLevel = 0)
        {
            MouseClick, left, %xH%, %yH%
            Sleep, 2000
		}
		;MsgBox % Errorlevel

		x1 := AllRegion[1]
		y1 := AllRegion[2]
		x2 := AllRegion[3]
		y2 := AllRegion[4]
		; Click search
        ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\search.jpg
        if (ErrorLevel = 0)
        {
            MouseClick, left, %xH%, %yH%
            Sleep, 2000
		}
		;MsgBox % Errorlevel
		
		; Click group
        ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\group.jpg 
        if (ErrorLevel = 0)
        {
            MouseClick, left, %xH%, %yH%
            Sleep, 2000
		}
		;MsgBox % Errorlevel
		 
		Loop
		{
			; Click APC1
			ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\APC1.bmp
			; BBC8D0
			;PixelSearch, xH, yH, 854, 868, 858, 867, 0xBBC8D0, 25, 0
			;MsgBox % Errorlevel			
			if (ErrorLevel = 0)
			{
				MouseClick, left, %xH%, %yH%
				Sleep, 250
			} else {
				count += 1
				break
			}
			;MsgBox % Errorlevel
		
			
			; Click March
			ImageSearch, xH, yH, x1, y1, x2, y2, *100 C:\Users\Fred\Git\autohotkey\Assets\Darkwars_hospital\March.jpg 
			; 6FC3BB  1031, 659
			;PixelSearch, xH, yH, 1022, 667, 1022, 667, 0xBBC46F, 50, 0			
			;MsgBox % Errorlevel
			
			if (ErrorLevel = 0)
			{
				MouseClick, left, %xH%, %yH%
				Sleep, 30000
				count := 0
				break
			} else {
				count += 1
				if (count > loopCount)
				{
					ExitApp  ; Exit the script when count exceeds 20
				}
				ToolTip, Count: %count%  ; Display the count (optional)
				Sleep, 1000 * 60 * 0.25 ; sleep 0.25 minutes
			}
			
		}
		
		
		
    }
    Sleep, 1000
}


; ===== HOTKEY: ESC to exit =====
Esc::
BlockInput, Off
ExitApp