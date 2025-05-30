#Requires AutoHotkey v2.0

splash() {
    sleep (1000)

    count := 0
    loop 10 {
        if (getCurrentScreen() = SCREEN_SHELTER) {
            count += 1
            if count > 2 {
                LoggerInstance.Debug("World Found")
                break
            }
        }
        
        if (ImageFinderInstance.FindAnyImageObjects(1000, false, O_survivorProfile).found) {
            LoggerInstance.Debug("Surviror profile found")
            break
        }

        clickAnyX()
        iconPlayerClickBlind()
        Sleep(500)
    }

    clickAnyX()
    clickAnyBack()

}
