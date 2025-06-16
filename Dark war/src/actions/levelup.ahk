#Requires AutoHotkey v2.0

O_levelup := Image("Levelup.bmp", 25, Regions.icons.levelup)

levelup() {

    if ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 10, 60, O_levelup).found {
        LoggerInstance.Info("Found Levelup")
        MouseClick("left", Positions.icons.levelupchat[1], Positions.icons.levelupchat[2])
        Sleep(1000)
        ClaimOCR(1000)
        WaitFindText("(?i)open", Map(
            "Click", true,
            "ClickDelay", 3000,
            "LoopDelay", 8000,
            "Region", Regions.events.main,
            "ocrOptions", Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 1)
        ))
        iconPlayerClickBlind()
        iconPlayerClickBlind()
        clickAnyBack()
        levelup()  ;check if another levelup
    }

}
