#Requires AutoHotkey v2.0

O_splashGuy := Image("splash_guy.bmp", 100, Regions.AllRegion)

LoadingWait() {
    LoggerInstance.info("Loading game ... Waiting for splash")

    found := false
    World := 0
    loop 10 {

        ;currentscreen := getCurrentScreen()

        ; If shelter is shown for more than 6 seconds, break
        if (Screens.Shelter.Shelter.WaitForMatch(LoopDelay := 250)) {

            ;shelter found, trying multiples times
            loop 5 {
                Sleep (1000)
                if (Screens.Shelter.Shelter.WaitForMatch(LoopDelay := 500)) {
                    World += 1
                    LoggerInstance.debug("World found : " World)
                    if (World >= 4) {
                        LoggerInstance.Info("World found")
                        return true
                    }
                } else {
                    World := 0
                    LoggerInstance.debug("World is gone")
                    break
                }
            }

            if (Screens.Mains.Guy.WaitForMatch(LoopDelay := 250)) {
                LoggerInstance.Info("Splash guy found")
                Sleep(5000)
                return true
            }
            ; If android icon, click on it.
            if (Screens.Mains.Android.WaitForMatch(LoopDelay := 250)) {
                LoggerInstance.Warn("Android screen")
                WaitFindText("Dark War", Map("Click", true, "ClickDelay", 10000, "LoopDelay", 8000, "Region", Regions.AllRegion))

                ;failsafe
                ImageFinderInstance.LoopFindImage(AndroidIcon, Regions.AllRegion, 50, 10000, true, 50, 2)
            }
            Sleep(2000)

        }
        return found
    }
}
