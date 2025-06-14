#Requires AutoHotkey v2.0

O_switch_account := Image("switch_account.bmp", 50, Regions.AllRegion)
O_switch_switch_character := Image("switch_character.bmp", 50, Regions.AllRegion)
O_switch_yes := Image("switch_yes.bmp", 50, Regions.AllRegion)

LoginAndSetUser(CurrentUser) {
    LoggerInstance.Debug("Checking user: " CurrentUser.name)

    f := false
    i := 0
    loop 5 {
        iconPlayerClickBlind()

        if Screens.titles.Survivor.WaitForMatch(3000) {
            f := true
        } else if (i >= 5) {
            LoggerInstance.WARN("Error, not in survivor profile")
            return false
        }

        i++

    } until f

    ; WaitFindText(CurrentUser.regex, ocrOptions)
    ;ocrOptions := Map("Region", Regions.events.main, )

    if WaitFindText(CurrentUser.regex, Map(
        "Click", false,
        "ClickDelay", 1000,
        "LoopDelay", 5000,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 3)
    )) {

        CurrentUser.active := true
        LoggerInstance.info("CurrentUser " CurrentUser.name " is active - returning")
        clickAnyBack()
    } else {
        CurrentUser.active := false
        LoggerInstance.info("CurrentUser " CurrentUser.name " is not active - Switching")

        WaitFindText("(?i)Account", Map(
            "Click", true,
            "ClickDelay", 1000,
            "LoopDelay", 5000,
            "Region", Regions.events.bottom
        ))

        WaitFindText("(?i)Character", Map(
            "Click", true,
            "ClickDelay", 1000,
            "LoopDelay", 5000,
            "Region", Regions.events.main
        ))

        username := RegExReplace(CurrentUser.name, "[ilo]", ".")
        username := "(?i)\[.{1,6}\]" username  ; Contains [...]Username
        WaitFindText(username, Map(
            "Click", true,
            "ClickDelay", 1000,
            "LoopDelay", 5000,
            "Region", Regions.events.main
        ))

        WaitFindText("(?i)Yes", Map(
            "Click", true,
            "ClickDelay", 1000,
            "LoopDelay", 5000,
            "Region", Regions.events.main
        ))

        ;ImageFinderInstance.FindAnyImageObjects(1000, true, O_switch_account)
        ;ImageFinderInstance.FindAnyImageObjects(1000, true, O_switch_switch_character)

    }

    ; Swtich account menu
    /*
        ; check if the user is active. Swtich if not
        if ImageFinderInstance.FindAnyImageObjects(2000, true, CurrentUser.img).Found {
            LoggerInstance.info("CurrentUser is not active - Switching")
            ImageFinderInstance.FindAnyImageObjects(1000, true, O_switch_yes)
    
        } else {
            CurrentUser.active := true
            LoggerInstance.info("CurrentUser is active - returning")
            iconPlayerClickBlind()
            iconPlayerClickBlind()
            clickAnyBack()
    
        }
    */
    return CurrentUser.active

}
