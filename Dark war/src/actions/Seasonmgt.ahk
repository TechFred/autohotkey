#Requires AutoHotkey v2.0

O_iconseasonmgt := Image("icon_seasonmgt_transblack.bmp", 50, Regions.menus.left, TransBlack)

IconSeasonmgtClick() {
    if goToWorldOCR() {
        return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, O_iconseasonmgt)
    } else {
        LoggerInstance.Warn("Error, World not found - Quitting")
        return false
    }
}

SeasonMgt() {

    if IconSeasonmgtClick() {

        if Screens.titles.SeasonMgt.WaitForMatch(3000) {
            LoggerInstance.debug("SeasonMgt found")

            WaitFindText("(?i)ollect", Map(
                "Click", true,
                "ClickDelay", 2000,
                "LoopDelay", 8000,
                "Region", Regions.events.main,
                "ocrOptions", Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 1)
            ))
            RemoveCongratOCR()
            ExitSeasonmgt()
        }

    }
}

ExitSeasonmgt() {
    LoggerInstance.debug("SeasonMgt exiting")
    loop 10 {
        if Screens.titles.SeasonMgt.WaitForMatch(3000) {
            clickAnyBack()
            goToShelterOCR()
            if Screens.Shelter.Shelter.WaitForMatch(5000) {
                LoggerInstance.debug("Shelter found")
                break

            }

        } else {
            LoggerInstance.debug("Lost - crashdetection")
            CrashDetection()
        }
        Sleep (2000)
    }

}
