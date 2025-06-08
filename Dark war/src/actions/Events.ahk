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

O_reddot_transblack_main := O_reddot_transblack.Clone()
O_reddot_transblack_main.region := Regions.Events.main

O_reddot_number_transblack_bottom := O_reddot_number_transblack.Clone()
O_reddot_number_transblack_bottom.region := Regions.events.bottom

O_reddot_number_transblack_main := O_reddot_number_transblack.Clone(, Regions.events.Main)

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
    iconEventsClick()
    if ImageFinderInstance.FindAnyImageObjects(1000, false, Events_title).found {
        LoggerInstance.Debug("Events menu")

        i := 0
        loop 20 {
            ShadowCalls()
            TitanClaim()

            ;ImageFinderInstance.FindAnyImageObjects(2000, true, O_reddot_number_transblack)

            ;Manque probablement le clic sur les élements en rouges reddot dans le bas.

            if ImageFinderInstance.FindAnyImageObjects(2000, true, O_reddot_number_transblack_bottom).found {
                LoggerInstance.Debug("Red number found in menu")
                ClickReddot(1000, Regions.events.main)  ;If reddot, click on it
                ImageFinderInstance.FindAnyImageObjects(2000, true, O_reddot_number_transblack_main)
                ClaimOCR()
                ClaimAllOCR()

            } else if (ImageFinderInstance.FindAnyImageObjects(2000, true, ImagesNew*).found) {

            } else if (ImageFinderInstance.FindAnyImageObjects(2000, true, ImagesExclamation*).found) {

            } else {
                LoggerInstance.Debug("Nothing found, looping: " i)
                i += 1
            }

            if !(ImageFinderInstance.FindAnyImageObjects(1000, false, Events_title).found) {  ;If events menu is not found, go back
                LoggerInstance.Debug("Events title not found -> going back")
                clickAnyX()
                iconPlayerClickBlind()
            }
            ClickReddot(1000, Regions.menus.bottom)  ;Click on reddot in the menu

        } until i > 5
    }
    clickAnyBack()
}

;O_reddot_number_transblack

;O_Events_exclamation_transblack

ShadowCalls() {

    ;If Ally mission present, good menu
    if ImageFinderInstance.FindAnyImageObjects(1000, false, ShadowCalls_AllyMissions).found {
        LoggerInstance.Debug("Found ShadowsCalls - Ally Mission")

        ;Personnal missions
        ImageFinderInstance.FindAnyImageObjects(2000, true, O_claim_green_main)

        loop 5 {
            ImageFinderInstance.FindAnyImageObjects(1000, true, ShadowCalls_AllyMissions)
            ;Click Help
            ImageFinderInstance.FindAnyImageObjects(2000, true, O_claim_green_main)
            ImageFinderInstance.FindAnyImageObjects(1000, true, ShadowCall_Assist_title)
            ImageFinderInstance.FindAnyImageObjects(1000, true, ShadowCall_Congrat_bob)
        }

    }

}

BioMutant() {
    ; todo
}

TitanClaim() {
    if ImageFinderInstance.FindAnyImageObjects(1000, false, O_Titan_title).found {
        MouseClick("left", 970, 712, 2)
        Sleep(2000)
        Remove_Congrat()
    }
}
