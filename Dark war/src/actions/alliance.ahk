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

    if goToShelterOCR() {
        if (iconAllianceClick()) {

            AllianceTech()
            AllianceWars()
            AllianceGifts()

            clickAnyBack()

        } else {
            LoggerInstance.warn("lost in menus")
        }

    }
    else {
        LoggerInstance.warn("lost in menus")
    }

}

AllianceTech() {
    ;
    LoggerInstance.debug("Alliance Tech")
    if WaitFindText("(?i)Alliance Tech", Map(
        "Click", true,
        "ClickDelay", 2000,
        "LoopDelay", 4000,
        "Region", Regions.events.main,
        "ocrOptions", Map("scale", 1)
    )) {

        if (ImageFinderInstance.LoopFindImage(tech_thumb, Regions.AllRegion, 70, 1000, true, loopDelay := 1000, attempts := 5).Found) {

            ;todo remplacer par clickloop
            i := 0
            loop {
                img := ImageFinderInstance.LoopFindImage(tech_donate, Regions.AllRegion, 50, 250, true, 10, 3)
                if (img.Found) {
                    LoggerInstance.debug("Tech Donate")
                    i := 0
                } else if (ImageFinderInstance.FindImage(tech_donate_done, Regions.AllRegion, tolerance := 50, clickDelay := 1000, doClick := false).found) {
                    LoggerInstance.debug("Tech Donate Done found")
                    break
                } else {
                    LoggerInstance.debug("Tech Donate not found")
                    i += 1
                    Sleep(250)
                }

            } until (i > 10)

            iconPlayerClickBlind(500)
            iconPlayerClickBlind(500)
        }

        clickAnyBack()
    }
}

AllianceGifts() {
    LoggerInstance.debug("Alliance Gifts")

    if WaitFindText("(?i)Gifts", Map(
        "Click", true,
        "ClickDelay", 2000,
        "LoopDelay", 4000,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 5)
    )) {
        ClaimAllOCR(, Regions.events.bottom)
        ;ClaimLoopOCR(250, 3)

        ;rare gifts

        if WaitFindText("(?i)Rare", Map(
            "Click", true,
            "ClickDelay", 2000,
            "LoopDelay", 4000,
            "Region", Regions.events.main,
            "ocrOptions", Map("scale", 1)
        )) {
            ClaimAllOCR(, Regions.events.bottom)
            ClaimLoopOCR(250, 20)
        }

        clickAnyBack()

    }

}

AllianceWars() {
    LoggerInstance.debug("Alliance Wars")

    if WaitFindText("(?i)Wars", Map(
        "Click", true,
        "ClickDelay", 2000,
        "LoopDelay", 4000,
        "Region", Regions.events.main,
        ;"ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
        "ocrOptions", Map("casesense", 0, "grayscale", 0, "invertcolors", 1, "lang", "en-us", "mode", 4, "monochrome", 220, "scale", 1)


        
    )) {
        ;Team Up tab
        WaitFindText("(?i)Team Up", Map(
            "Click", true,
            "ClickDelay", 2000,
            "LoopDelay", 4000,
            "Region", Regions.events.main,
            "ocrOptions", Map("scale", 1)
        ))

        ;Button Auto Team-Up
        WaitFindText("(?i)Auto Team-up", Map(
            "Click", true,
            "ClickDelay", 2000,
            "LoopDelay", 4000,
            "Region", Regions.events.bottom,
            "ocrOptions", Map("casesense", 0, "grayscale", 0, "invertcolors", 1, "lang", "en-us", "mode", 4, "monochrome", 200, "scale", 1)
        ))

        WaitFindText("(?i)Enable", Map(
            "Click", true,
            "ClickDelay", 2000,
            "LoopDelay", 4000,
            "Region", Regions.events.main,
            "ocrOptions", Map("scale", 1)
        ))

        iconPlayerClickBlind(500)
        iconPlayerClickBlind(500)
        clickAnyBack()
    }

}
