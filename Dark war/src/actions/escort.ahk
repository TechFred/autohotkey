#Requires AutoHotkey v2.0
O_escort_menu := Image("escort.bmp", 50, Regions.menus.bottom)
O_escort_expeditionGift := Image("expedition_gift.bmp", 100, Regions.AllRegion)
O_escort_escortGift := Image("escort_gift.bmp", 20, Regions.AllRegion)

ImagesGift := [
    O_escort_expeditionGift,
    O_escort_escortGift
]
Escorts() {
    if iconEscortClick().found {

        ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 200, 5, O_escort_menu)
        LoggerInstance.Debug("Escort menu")

        i := 0
        x := 2
        loop {
            if (ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 20, 5, ImagesGift*)).found {
                LoggerInstance.Debug("Found Chest")
                clickAnyBack()
                Remove_Congrat()
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
