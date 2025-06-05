#Requires AutoHotkey v2.0

HighlightRegion(region, duration := 5000) {
    ; Create GUI with no border and transparent background
    guiobj := Gui("+AlwaysOnTop -Caption +ToolWindow +LastFound")
    guiobj.BackColor := "Red"

    ; Calculate width and height
    w := region[3] - region[1]
    h := region[4] - region[2]

    ; Set the position and size
    guiobj.Show("x" region[1] " y" region[2] " w" w " h" h)

    ; Make the GUI semi-transparent (optional)
    WinSetTransparent(150, "ahk_id " guiobj.Hwnd)

    ; Wait, then destroy
    SetTimer (*) => guiobj.Destroy(), -duration
}

HighlightRegionInWindow(region, duration := 5000) {
    try {
        ; Get window position
        WinGetPos(&wx, &wy, , , winTitle)

        ; Offset region coordinates relative to the window
        x := wx + region[1]
        y := wy + region[2]
        w := region[3] - region[1]
        h := region[4] - region[2]

        ; Create transparent GUI for highlight
        guiobj := Gui("+AlwaysOnTop -Caption +ToolWindow +LastFound")
        guiobj.BackColor := "Red"
        guiobj.Show("x" x " y" y " w" w " h" h)
        WinSetTransparent(150, "ahk_id " guiobj.Hwnd)

        ; Auto destroy after duration
        SetTimer (*) => guiobj.Destroy(), -duration
    } catch as e {
        MsgBox "Error highlighting region: " e.Message
        MsgBox "Error highlighting region: " e.stack
    }
}
