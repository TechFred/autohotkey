#Requires AutoHotkey v2.0

Events_new := Image("Events_new.bmp", 25, Regions.icons.events)
Events_title := Image("Events_title.bmp", 25, Regions.AllRegion)
ShadowCalls_title := Image("ShadowCalls_title.bmp", 25, Regions.AllRegion)
ShadowCalls_AllyMissions := Image("Shadow_AllyMissions.bmp", 50, Regions.AllRegion)
ShadowCall_Assist_title := Image("Shadow_Assist.bmp", 25, Regions.AllRegion)
Events_new_btn := Image("Events_new_bnt.bmp", 70, Regions.events.bottom)
Events_new_btn_2 := Image("Events_new_bnt_2.bmp", 70, Regions.events.bottom)
Events_new_bnt_3 := Image("Events_new_bnt_3.bmp", 70, Regions.events.bottom)

ShadowCall_Congrat_bob := Image("Congrat_bob.bmp", 25, Regions.AllRegion)
O_Titan_title := Image("Titan_title.bmp", 50, Regions.AllRegion)

O_claim_green_main := O_claim_green.Clone()
O_claim_green_main.region := Regions.Events.main

ImagesExclamation := [
    O_Events_exclamation_transblack_Right,
    O_Events_exclamation_transblack_LEFT
]

ImagesNew := [
    Events_new_btn,
    Events_new_btn_2,
    Events_new_bnt_3
]

events() {
    if (ClickNew(Regions.icons.events)) {

    } else {
        iconRegionRedDotNbClick(Regions.icons.events)
    }

    EventsLoop(Screens.Titles.events)
}

premiumCenter() {
    iconRegionRedDotNbClick(Regions.icons.premium_center)
    EventsLoop(Screens.Titles.Premium)
}

pack_shop() {
    iconRegionRedDotNbClick(Regions.icons.pack_shop)
    EventsLoop(Screens.Titles.pack_shop)
}

EventsLoop(screen) {

    reddotBottom := O_reddot_transblack.Clone(, Regions.events.Bottom)
    rednumberBottom := O_reddot_number_transblack.Clone(, Regions.events.Bottom)

    i := 0
    loopsmax := 5

    if screen.WaitForMatch() {
        LoggerInstance.Debug("Menu - " screen.name)

        startTime := A_TickCount
        maxDuration := 3 * 60 * 1000  ; 3 minutes in milliseconds

        loop 20 {
            if (ImageFinderInstance.FindAnyImageObjects(1000, true, reddotBottom).found) || (ImageFinderInstance.FindAnyImageObjects(1000, true, rednumberBottom).found) || ClickNew(Regions.events.bottom) {
                LoggerInstance.Debug("Found reddot in menu")
                i := 0
                EventsClaims(screen)
            } else if (ExclamationClick().found) {
                i := 0
            } else if (!screen.WaitForMatch(2000)) {
                clickAnyBack()
                iconPlayerClickBlind(250)

            } else {
                i += 1
                Sleep(1000)
            }

        } until i >= loopsmax || A_TickCount - startTime < maxDuration

        loop 5 {
            if (!screen.WaitForMatch(250)) {
                clickAnyBack()
                iconPlayerClickBlind(250)
            }
        }
        ExitEvents(screen)
    }

}

EventsClaims(screen) {
    reddotMain := O_reddot_transblack.Clone(, Regions.events.main)
    rednumberMain := O_reddot_number_transblack.Clone(, Regions.events.Main)
    loopsmax := 2
    i := 0

    isEvents := screen.name = Screens.titles.events.name
    isPremium := screen.name = Screens.titles.Premium.name

    ;Biomutant
    ;FactionTrials
    if (screen.name = Screens.titles.events.name) && (ShadowCalls() || TitanClaim() || FactionTrials()) {  ; Or Other specials.
        LoggerInstance.Debug("Begin special claiming")

        ;Nothing to do. Return
        return
    } else {
        LoggerInstance.Debug("Begin normal claiming")
        ClaimAllOCR(, Regions.Events.main)  ; Slow! Voir comment accélérer
        ClaimLoopOCR(, 2, Regions.events.main)  ; slow! Voir comment accélérer
        iconPlayerClickBlind(250)  ;Go back
        iconPlayerClickBlind(250)  ;Go back

        loop 5 {
            if (reddotMain.ClickOffsetTopLeft(1000).found) || (ImageFinderInstance.FindAnyImageObjects(1000, true, rednumberMain).found) {
                LoggerInstance.Debug("Found reddot in main")
                i := 0
                ClaimAllOCR(, Regions.Events.main)
                ClaimLoopOCR(, 3, Regions.events.main)

                ;ClaimFree
                WaitFindText("(?i)\bFree\b", Map(
                    "Click", true,
                    "ClickDelay", 1000,
                    "LoopDelay", 250,
                    "Region", Regions.events.main,
                    "ocrOptions", Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 1, "invertcolors", 1, "monochrome", 225)  ;Bouton jaune, texte blanc
                ))
                iconPlayerClickBlind(250)
                if !screen.WaitForMatch(2000) {
                    LoggerInstance.Debug("Not in Event menu")
                    iconPlayerClickBlind(250)  ;Go back
                    iconPlayerClickBlind(250)  ;Go back

                    clickAnyBack()

                }

            } else {
                i += 1
                Sleep(1000)
            }

        } until i >= loopsmax

    }

}

ReturnEvents() {

    Isevents := Screens.Titles.events.WaitForMatch()
    if !Isevents {
        LoggerInstance.debug("Not in event, trying to go back")
        loop 5 {
            iconPlayerClickBlind(1000)
            Isevents := Screens.Titles.events.WaitForMatch()

        } until Isevents
    }
    ;if not found, crash!
    if !Isevents() {
        CrashDetection()
    }
    return Isevents
}

FactionTrials() {
    FactionTrials := false
    FactionTrials := (WaitFindText("(?i)Facti.. TR.a.s", Map(
        "Click", false,
        "ClickDelay", 2000,
        "LoopDelay", 1000,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 0, "invertcolors", 1, "lang", "en-us", "mode", 4, "monochrome", 200, "scale", 1)
    )))

    ;do nothing here
    return FactionTrials
}

ShadowCalls() {
    IsShadowCall := false
    IsShadowCall := (WaitFindText("(?i)S.adow Calls", Map(
        "Click", false,
        "ClickDelay", 2000,
        "LoopDelay", 1000,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
    )))

    if IsShadowCall {
        LoggerInstance.Debug("Found ShadowsCalls - Ally Mission")

        ;personal missions
        ClaimOCR(2000, 2000, Regions.events.main)
        RemoveCongratOCR(, , Regions.events.main)

        ;ally missions
        if (WaitFindText("(?i)Ally Missions", Map(
            "Click", true,
            "ClickDelay", 2000,
            "LoopDelay", 1000,
            "Region", Regions.events.main,
            "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
        ))) {

            loop 5 {
                ;click help
                if WaitFindText("(?i)Help", Map(
                    "Click", true,
                    "ClickDelay", 2000,
                    "LoopDelay", 2000,
                    "Region", Regions.events.main,
                    "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
                )) {
                    RemoveSuccessful()
                }

            }
        }
    }
    return IsShadowCall
}

BioMutant() {
    ; todo
}

TitanClaim() {
    rednumberMain := O_reddot_number_transblack.Clone(, Regions.events.Main)

    IsTitan := false
    IsTitan := (WaitFindText("(?i)Titan", Map(
        "Click", false,
        "ClickDelay", 2000,
        "LoopDelay", 1000,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 1)
    )))

    if IsTitan {
        if ImageFinderInstance.FindAnyImageObjects(1000, false, rednumberMain).found {
            ClaimLoopOCR(, 5, Regions.events.main)
            iconPlayerClickBlind(250)
            iconPlayerClickBlind(250)

        }
        MouseClick("left", Positions.titan.claim[1], Positions.titan.claim[2])
        Sleep(2000)

    }

}

iconeventsClick() {
    _icon := O_reddot_number_transblack.Clone(, Regions.icons.events)

    goToShelterOCR()
    _i := ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 500, 5, _icon)

    if _i.found {
        MouseClick("left", _i.x - 10, _i.y + 10)
        Sleep(2000)
    }

    return _i
}

RemoveSuccessful() {
    WaitFindText("(?i)Successful", Map(
        "Click", true,
        "ClickDelay", 1000,
        "LoopDelay", 1,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 3)
    ))

}

ExitEvents(screen) {
    if (screen.WaitForMatch(3000)) {

        loop 5 {
            clickAnyBack()

        } until Screens.Shelter.shelter.WaitForMatch(250) || Screens.Shelter.world.WaitForMatch(250)

    }
}

ExclamationClick() {
    _r := ImageFinderInstance.FindAnyImageObjects(1000, false, O_Events_exclamation_transblack)

    if _r.found {
        MouseClick("left", _r.x, _r.y + 10)
        Sleep(2000)
    }

    return _r

}

iconRegionRedDotNbClick(Region) {
    _icon := O_reddot_number_transblack.Clone(, Region)

    goToShelterOCR()
    _i := ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 500, 5, _icon)

    if _i.found {
        ClickCenter(Region, 3000)
    }

    return _i
}

vip() {
    rdn := O_reddot_number_transblack.Clone(, Regions.events.main)
    rd := O_reddot_transblack.Clone(, Regions.events.main)

    LoggerInstance.debug("VIP")
    goToShelterOCR()
    iconPlayerClickBlind(2000)
    ImageFinderInstance.FindAnyImageObjects(1000, true, rdn)
    rd.ClickOffsetTopLeft()

    /*
    m := ClaimOCR(, 1000, Regions.events.main)
    if m {
        LoggerInstance.debug("Claiming VIP")
        MouseClick("left", m.x, m.y - 25)
    }
    */
    iconPlayerClickBlind(250)
    clickAnyBack()
    iconPlayerClickBlind(250)
    clickAnyBack()
}

ClickNew(region := Regions.AllRegion) {

    match := WaitFindText("(?i)\bNew\b", Map(
        "Click", true,
        "ClickDelay", 1000,
        "LoopDelay", 500,
        "Region", region,
        "ocrOptions", Map("casesense", 0, "grayscale", 0, "invertcolors", 1, "lang", "en-us", "mode", 4, "monochrome", 200, "scale", 3)  ;texte blanc
    ))

    if !match {
        WaitFindText("(?i)\bNew\b", Map(
            "Click", true,
            "ClickDelay", 1000,
            "LoopDelay", 500,
            "Region", region,
            "ocrOptions", Map("casesense", 0, "grayscale", 0, "invertcolors", 1, "lang", "en-us", "mode", 4, "monochrome", 200, "scale", 1)  ;texte blanc
        ))
    }
    return match
}
