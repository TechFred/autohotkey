#Requires AutoHotkey v2.0

FindPixelColorRegion(ClickDelay := 2000, DoClick := true, targetColor := 0xF3AC41, region := Regions.AllRegion) {
    LoggerInstance.debug("Searching for pixel color " targetColor)
    found := PixelSearch(&x, &y, region[1], region[2], region[3], region[4], targetColor, 5)

    if found {
        if DoClick {
            MouseMove(x, y)
            MouseClick("left", x + 5, y + 10)
            Sleep(ClickDelay)
            LoggerInstance.debug("Found pixel at " x ", " y " and clicked")
        } else {
            LoggerInstance.debug("Found pixel at " x ", " y)
        }
        return true
    } else {
        return false
    }

}
