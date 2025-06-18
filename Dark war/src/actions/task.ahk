#Requires AutoHotkey v2.0

O_iconTasks := Image("daily_task.bmp", 50, Regions.icons.tasks)

Task() {

    if (iconTasksClick().found && Screens.Mains.Daily.WaitForMatch()) {

        ;ClaimAllOCR(, Regions.DailyTasks.ClaimAll)
        ;ClaimOCR(, , Regions.DailyTasks.Claim)

        ClaimAllOCR(, Regions.events.main)
        ClaimLoopOCR(, 10, Regions.events.main)

        loop 3 {
            if ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, O_reddot_number_transblack).found {
                ClaimAllOCR(, Regions.events.main)
                ClaimLoopOCR(, 10, Regions.events.main)
            } else {
                break
            }
        }
        ;clickAnyX()
        iconPlayerClickBlind()  ; exit
        ExitTask()  ; failsafe exit

    }

}

ExitTask() {
    if (Screens.mains.Daily.WaitForMatch(3000)) {

        loop 5 {
            iconPlayerClickBlind()

        } until Screens.Shelter.shelter.WaitForMatch(250) || Screens.Shelter.world.WaitForMatch(250)

    }
}

iconTasksClick() {
    _icon := O_reddot_number_transblack.Clone(, Regions.icons.tasks)

    goToShelterOCR()
    _i := ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 500, 5, _icon)

    if _i.found {
        MouseClick("left", _i.x - 10, _i.y + 10)
        Sleep(2000)
    }

    return _i
}
