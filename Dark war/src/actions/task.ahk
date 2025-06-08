#Requires AutoHotkey v2.0

Task() {

    if (iconTasksClick().found) {
        ClaimAllOCR(, Regions.DailyTasks.ClaimAll)
        ClaimOCR(, , Regions.DailyTasks.Claim)

        clickAnyX()

        loop 20{
            ExitTask()
        } until Screens.Shelter.shelter.found || Screens.Shelter.world.found

    }
}

ExitTask() {
    if (Screens.mains.Daily.WaitForMatch()) {

        loop 20 {
            MouseClick("left", 847, 1024)

        } until Screens.Shelter.shelter.found || Screens.Shelter.world.found

    }
}

iconTasksClick() {
    goToShelter()
    return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, O_iconTasks)
}