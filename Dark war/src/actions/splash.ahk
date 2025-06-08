#Requires AutoHotkey v2.0

splash() {
    count := 0
    loop 10 {
        if (Screens.Shelter.Shelter.WaitForMatch(LoopDelay := 500)) {
            iconHeroesClickBlind(1000)
        }

        loop 3 {
            if (Screens.titles.HeroList.WaitForMatch(LoopDelay := 500) OR Screens.titles.Survivor.WaitForMatch(LoopDelay := 500)) {
                LoggerInstance.Debug("Heroes or profile found")
                clickAnyX()
                clickAnyBack()
                return true

            }
            iconHeroesClickBlind(250)
            iconPlayerClickBlind(250)
            iconHeroesClickBlind(250)
            iconHeroesClickBlind(250)
            iconHeroesClickBlind(250)
            iconPlayerClickBlind(250)

        }
        ; If not in herolist or player profile, try Click X.
        clickAnyX()
    }

}
