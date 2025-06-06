#Requires AutoHotkey v2.0

O_splashGuy := Image("splash_guy.bmp", 100, Regions.AllRegion)

LoadingWait() {
    LoggerInstance.info("Loading game ... Waiting for splash")

    found := false
    World := 0
    loop 20 {

        ;currentscreen := getCurrentScreen()

        ; If world is shown for more than 6 seconds, break
        if (Screens.Shelter.Shelter.Find) {
            World += 1
            LoggerInstance.debug("World found : " World)
            if (World > 3) {
                LoggerInstance.Info("World found")
                return true
            }

        } else {
            World := 0
        }

        if (Screens.Mains.Guy.Find) {
            LoggerInstance.Info("Splash guy found")
            Sleep(5000)
            return true
        }

        ; If android icon, click on it.
        if (Screens.Mains.Android.Find) {
            LoggerInstance.Warn("Android screen")
            WaitFindText("Dark War", Map("Click", true, "ClickDelay", 10000, "LoopDelay", 8000, "Region", Regions.AllRegion))
            
            ;failsafe
            ImageFinderInstance.LoopFindImage(AndroidIcon, Regions.AllRegion, 50, 10000, true, 50, 2)
        }
        Sleep(2000)

    }
    return found
}
