#Requires AutoHotkey v2.0

O_splashGuy := Image("splash_guy.bmp", 100, Regions.AllRegion)

LoadingWait() {
    LoggerInstance.info("Loading game ... Waiting for splash")

    found := false
    World := 0
    loop 10 {
        if (ImageFinderInstance.FindAnyImageObjects(1000,false, O_splashGuy).found) {
            Sleep(5000) ; Give time to load
            LoggerInstance.Info("Splash guy found")
            found := true
            break
        }

        ; If world is shown for more than 6 seconds, break
        if (getCurrentScreen() = SCREEN_SHELTER) {
            World += 1
            LoggerInstance.debug("World found : " World) 
            if (World > 3) {
                LoggerInstance.Info("World found")
                found := true
                break
            }

        } else {
            World := 0
        }
        Sleep(2000)

    }
    return found
}
