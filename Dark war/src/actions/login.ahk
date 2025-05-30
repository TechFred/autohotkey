#Requires AutoHotkey v2.0

O_switch_account := Image("switch_account.bmp", 50, Regions.AllRegion)
O_switch_switch_character := Image("switch_character.bmp", 50, Regions.AllRegion)
O_switch_yes := Image("switch_yes.bmp", 50, Regions.AllRegion)

LoginAndSetUser(CurrentUser) {
    LoggerInstance.Debug("Checking user: " CurrentUser.name)

    loop 5 {
        iconPlayerClickBlind()
        M := ImageFinderInstance.FindAnyImageObjects(1000, false, O_survivorProfile).found

    } until M

    if !M {
        LoggerInstance.WARN("Error, not in menu")
        return false
    }

    ; Swtich account menu
    ImageFinderInstance.FindAnyImageObjects(1000, true, O_switch_account)
    ImageFinderInstance.FindAnyImageObjects(1000, true, O_switch_switch_character)

    ; check if the user is active. Swtich if not
    if ImageFinderInstance.FindAnyImageObjects(2000, true, CurrentUser.img).Found {
        CurrentUser.active := false
        loggerInstance.info("CurrentUser is not active - Switching")
        ImageFinderInstance.FindAnyImageObjects(1000, true, O_switch_yes)

    } else {
        CurrentUser.active := true
        loggerInstance.info("CurrentUser is active - returning")
        iconPlayerClickBlind()
        iconPlayerClickBlind()
        clickAnyBack()

    }
    return CurrentUser.active

}
