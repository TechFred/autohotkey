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

ClickLoop(clickDelay := 1000, attempts := 10, Image1 := "", Image2 := "") {

    loop {
        img := ImageFinderInstance.FindAnyImageObjects(clickDelay, true, Image1)
        if (img.Found) {
            loggerInstance.debug(Image1.path " found")
            i := 0
        } else if (IsObject(Image2) && ImageFinderInstance.FindAnyImageObjects(clickDelay, false, Image2).found) {
            loggerInstance.debug(Image2.path " found -> stopping")
            break
        } else {
            loggerInstance.debug(Image1.path " not found")
            i += 1
            Sleep(250)
        }

    } until (i > attempts)

}
