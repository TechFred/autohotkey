#Requires AutoHotkey v2.0

CrashDetection() {
    LoggerInstance.debug("Running CrashDetection")
    scr := getCurrentScreenOCR()

    if scr {
        if scr.name = Screens.mains.Android.name {
            Checkfix_Screen_Android()
            throw Error("Game crashed")

        } else if scr.name = Screens.mains.logout.name {

            ;Click confim
            WaitFindText("(?i)confirm", Map(
                "Click", true,
                "ClickDelay", 5000,
                "LoopDelay", 8000,
                "Region", Regions.Events.main,
                "ocrOptions", Map("scale", 2)
            ))

            ;Rerun the crash detection
            LoggerInstance.Warn("Logout screen detected, rerunning crash detection")
            CrashDetection()
            return
        } else if scr.name = Screens.mains.Charactermgt.name {
            iconPlayerClickBlind()
            iconPlayerClickBlind()
            iconPlayerClickBlind()
            clickAnyBack()
        } else if scr.name = Screens.custom.BlueStacks.name {
            ToggleFullScreen()

        } else if scr.name = Screens.mains.GetEnergy.name {
            ExitBoomers()
        }

    }

    /*
        if (getCurrentScreen() = SCREEN_ANDROID) {
            Checkfix_Screen_Android()
            throw Error("Game crashed")  ; C:\Users\Fred\Git\autohotkey\Dark war\src\lib\CrashDetection.ahk (13) : ==> Expected a String but got a Class.
    
        }
    */

    if (!scr) {
        WinActivateGame()
        Checkfix_Screen_Unknown()

    }

}

; Logique nulle. À réviser.
Checkfix_Screen_Android() {
    LoggerInstance.warn("Running Android Checkfix_Screen_Android")
    i := 0
    loop {
        if (Screens.mains.Android.WaitForMatch(3000)) {
            return WaitFindText("Dark War", Map("Click", true, "ClickDelay", 10000, "LoopDelay", 8000, "Region", Regions.AllRegion))
        }
        i += 1
    } until (i > 20)

    if (i > 20) {

        scr := getCurrentScreenOCR()
        if (scr) {
            LoggerInstance.warn("Android screen not found, current screen: " scr.name)
        } else {
            LoggerInstance.warn("Android screen not found, current screen unknown")
        }
        RestartGame()
    }
}

Checkfix_Screen_Unknown() {
    LoggerInstance.warn("Running Android Checkfix_Screen_Unknown")
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
            iconPlayerClickBlind()
            iconPlayerClickBlind()
            iconPlayerClickBlind()
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
    LoggerInstance.warn("RestartGame")

    CloseApplication()
    WinWaitClose(winTitle)
    Sleep 10000
    StartDarkWar()
    throw Error("Game crashed")
}
