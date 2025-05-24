#Requires AutoHotkey v2.0+
CoordMode "Mouse", "Client"  ; important!

; Press Ctrl+Shift+R to start selection
^+r::
{
    global startX := 0, startY := 0, endX := 0, endY := 0

    ToolTip "Click and drag with your left mouse button to select a region..."

    ; Wait for left click
    while !GetKeyState("LButton", "P")
        Sleep 10
    MouseGetPos &startX, &startY

    ; Wait for release
    while GetKeyState("LButton", "P")
        Sleep 10
    MouseGetPos &endX, &endY

    /*
    ; Show coordinates (raw)
    MsgBox "Coordinates:`n"
        . "Start X: " startX "`n"
        . "Start Y: " startY "`n"
        . "End X: " endX "`n"
        . "End Y: " endY

        */

    ; Optional: copy to clipboard
    A_Clipboard := "[" startX "," startY "," endX "," endY "]"
    ToolTip 
}
