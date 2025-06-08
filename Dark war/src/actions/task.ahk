#Requires AutoHotkey v2.0

Task() {

    if (iconTasksClick().found) {
        ClaimAllOCR(,Regions.DailyTasks.ClaimAll)
        ClaimOCR(,,Regions.DailyTasks.Claim)
        
        clickAnyX()
    }
}
