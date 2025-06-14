#Requires AutoHotkey v2.0

O_iconTasks := Image("daily_task.bmp", 50, Regions.icons.tasks)

Task() {

    if (iconTasksClick().found) {
        ClaimAllOCR(, Regions.DailyTasks.ClaimAll)
        ClaimOCR(, , Regions.DailyTasks.Claim)

        clickAnyX()

        loop 20{
            ExitTask()
        } until Screens.Shelter.shelter.WaitForMatch(250) || Screens.Shelter.world.WaitForMatch(250)

    }
}

ExitTask() {
    if (Screens.mains.Daily.WaitForMatch()) {

        loop 20 {
            MouseClick("left", 847, 1024)

        } until Screens.Shelter.shelter.WaitForMatch(250) || Screens.Shelter.world.WaitForMatch(250)

    }
}

iconTasksClick() {
    goToShelterOCR()
    return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, O_iconTasks)
}