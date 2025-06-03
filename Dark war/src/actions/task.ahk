#Requires AutoHotkey v2.0

Task() {

    if (iconTasksClick().found) {
        ClaimOCR()
        ClaimAllOCR()
        clickAnyX()
    }
}
