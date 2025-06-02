#Requires AutoHotkey v2.0

CrashDetection() {
    LoggerInstance.debug("Crash verification")
    if (getCurrentScreen() = SCREEN_UNKNOWN) {
        WinActivateGame()
        Checkfix_Screen_Unknown()

    }

    if (getCurrentScreen() = SCREEN_ANDROID) {
        Checkfix_Screen_Android()
        throw Error ("Game crashed")

    }

}

Checkfix_Screen_Android() {

    i := 0
    loop {
        if (getCurrentScreen() = SCREEN_ANDROID) {
            return (ImageFinderInstance.LoopFindImage(AndroidIcon, Regions.AllRegion, 50, 5000, true, 50, 5).found)
        }
        i += 1
    }

    if (i > 20) {
        LoggerInstance.warn("Current screen " getCurrentScreen())
        RestartGame()
    }
}

Checkfix_Screen_Unknown() {
    i := 0
    if (getCurrentScreen() = SCREEN_UNKNOWN) {
        LoggerInstance.warn("Unknow screen - Trying to find a working screen")
        loop {
            clickAnyBack()
            clickAnyBack()
            clickAnyBack()
            clickAnyBack()
            clickAnyX()
            clickAnyX()
            clickAnyX()
            iconPlayerClick()
            iconPlayerClick()
            iconPlayerClick()
            clickAnyBack()
            clickAnyBack()
            splash()
            Sleep(5000)
            LoggerInstance.debug("Unknow screen " i)
            i += 1

        } until (!(getCurrentScreen() = SCREEN_UNKNOWN) OR (i > 20))

        if (i > 20) {
            LoggerInstance.warn("Unknowscreen. trying to restart")
            RestartGame()
        }

    }
}

RestartGame() {
    try ProcessClose("HD-Player.exe")
    WinWaitClose(winTitle)
    sleep 10000
    StartDarkWar()
     throw Error ("Game crashed")
}
