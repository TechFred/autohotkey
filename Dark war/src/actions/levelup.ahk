#Requires AutoHotkey v2.0

O_levelup := Image("Levelup.bmp", 25, Regions.icons.levelup)

levelup() {

    if ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 10, 60, O_levelup).found {
        LoggerInstance.Info("Found Levelup")
        MouseClick("left",1236, 71)
        Sleep(1000)
        ClaimOCR(1000)
        Claim(1000,1)
        MouseClick("left", 1084, 655)
        Sleep(1000)
        iconPlayerClickBlind()
        iconPlayerClickBlind()
        clickAnyback()
        levelup() ;check if another levelup
    }
    
}
