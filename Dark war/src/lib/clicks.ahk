#Requires AutoHotkey v2.0

ClickCenter(region, clickDelay) {
    ; region = [x1, y1, x2, y2]
    x1 := region[1], y1 := region[2], x2 := region[3], y2 := region[4]

    ; Compute center
    centerX := Round((x1 + x2) / 2)
    centerY := Round((y1 + y2) / 2)

    ; Click the center
    MouseClick("left", centerX, centerY)
    Sleep(clickDelay)
}
