#Requires AutoHotkey v2.0

alliance_gift := "alliance_gift.bmp"
alliance_tech := "alliance_tech.bmp"
alliance_wars := "alliance_wars.bmp"

;tech
tech_thumb := "tech_thumb.bmp"
tech_donate := "tech_donate.bmp"
tech_donate_done := "tech_donate_done.bmp"

;gifts
gift_rare := "gift_rare.bmp"

;wars
wars_auto_group := "wars_auto_group.bmp"
wars_clock := "wars_clock.bmp"
wars_enable := "wars_enable.bmp"
wars_team_up := "wars_team_up.bmp"

ImagesWars := [
    wars_auto_group,
    wars_clock
]

Alliance() {
    LoggerInstance.debug("Alliance")

    if (goToShelter() = SCREEN_SHELTER) {
        if (iconAllianceClick()) {

            allianceTech()
            AllianceWars()
            AllianceGifts()

            clickAnyBack()

        } else {
            LoggerInstance.warn("lost in menus")
        }

    } else {
        LoggerInstance.warn("lost in menus")
    }

}

AllianceTech() {
    LoggerInstance.debug("Alliance Tech")
    if (ImageFinderInstance.LoopFindImage(alliance_tech, Regions.AllRegion, 70, 1000, true, loopDelay := 1000, attempts := 5).Found) {

        if (ImageFinderInstance.LoopFindImage(tech_thumb, Regions.AllRegion, 70, 1000, true, loopDelay := 1000, attempts := 5).Found) {

            ;todo remplacer par clickloop
            i := 0
            loop {
                img := ImageFinderInstance.LoopFindImage(tech_donate, Regions.AllRegion, 50, 250, true, 10, 3)
                if (img.Found) {
                    loggerInstance.debug("Tech Donate")
                    i := 0
                } else if (ImageFinderInstance.FindImage(tech_donate_done, Regions.AllRegion, tolerance := 50, clickDelay := 1000, doClick := false).found) {
                    loggerInstance.debug("Tech Donate Done found")
                    break
                } else {
                    loggerInstance.debug("Tech Donate not found")
                    i += 1
                    Sleep(250)
                }

            } until (i > 10)

            clickAnyX()
        }

        clickAnyBack()
    }
}

AllianceGifts() {
    LoggerInstance.debug("Alliance Gifts")

    if (ImageFinderInstance.LoopFindImage(alliance_gift, Regions.AllRegion, 70, sleepDelay := 1000, true, loopDelay := 1000, attempts := 5).Found) {
        ClaimAllOCR(,Regions.menus.bottom)
        ClaimLoopOCR(250)

        ;rare gifts

        if (ImageFinderInstance.LoopFindImage(gift_rare, Regions.AllRegion, 70, sleepDelay := 1000, true, loopDelay := 1000, attempts := 4).Found) {
            ClaimAllOCR(,Regions.menus.bottom)
            ClaimLoopOCR(250)
        }

        clickAnyBack()

    }

}

AllianceWars() {
    LoggerInstance.debug("Alliance Wars")

    if (ImageFinderInstance.LoopFindImage(alliance_wars, Regions.AllRegion, 70, , true,  1000,  5).Found) {

        ;Team Up tab
        ImageFinderInstance.LoopFindImage(wars_team_up, Regions.AllRegion, 50,  1000, true,  10, 5)

        ;Button Auto Team-Up
        ImageFinderInstance.LoopFindAnyImage(Regions.menus.bottom, 70, 1000, true, 1000, 5, ImagesWars*)

        ImageFinderInstance.FindImage(wars_enable, Regions.AllRegion, 50, 1000, true)

        clickAnyX()
        clickAnyBack()
    }

}
