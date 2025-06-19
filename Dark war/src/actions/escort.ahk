#Requires AutoHotkey v2.0
O_escort_menu := Image("escort.bmp", 50, Regions.menus.bottom)
O_escort_expeditionGift := Image("expedition_gift.bmp", 100, Regions.AllRegion)
O_escort_escortGift := Image("escort_gift.bmp", 40, Regions.events.main)
O_escort_escortGift2 := Image("escort_gift2.bmp", 40, Regions.events.main)




ImagesGift := [
    O_escort_expeditionGift,
    O_escort_escortGift,
    O_escort_escortGift2
]
Escorts() {
    if iconEscortClick().found {

       WaitFindText("(?i)Escort", Map(
            "Click", true,
            "ClickDelay", 2000,
            "LoopDelay", 4000,
            "Region", Regions.menus.bottom,
            "ocrOptions", Map("scale", 1)
        ))
        LoggerInstance.Debug("Escort menu")

        i := 0
        x := 3
        loop {

            if (ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 20, 5, ImagesGift*)).found || FindPixelColorRegion(Sleep := 2000, DoClick := true, targetColor := 0xF3AC41, region := Regions.Events.main) {
                LoggerInstance.Debug("Found Chest")
                RemoveCongratOCR()
                clickAnyBack()
                i := 0
            } else {
                LoggerInstance.Debug("Chest not found: " i)
                i += 1
            }

        } until i > x
        clickAnyBack()
        clickAnyBack()
    }
}
