#Requires AutoHotkey v2.0

splash() {
    count := 0
    loop 10 {
        if (getCurrentScreen() = SCREEN_SHELTER) {
            iconPlayerClickBlind(1000)
            /*
            ;Ne fait pas ce que je veux. Le if d'après ouvre le profile de toute facon.
            count += 1
            if count > 2 {
                LoggerInstance.Debug("World Found")
                break
            }
            */
        }

        loop 2 {
            if (ImageFinderInstance.FindAnyImageObjects(1000, false, O_survivorProfile).found) {
                LoggerInstance.Debug("Surviror profile found")
                break
            }
            iconHeroesClickBlind(250)
            iconPlayerClickBlind(250)
            iconHeroesClickBlind(250)
            iconHeroesClickBlind(250)
            iconHeroesClickBlind(250)
            iconPlayerClickBlind(250)

        }

        clickAnyX()
    }

    clickAnyX()
    clickAnyBack()

}
