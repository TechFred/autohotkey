#Requires AutoHotkey v2.0

Task() {

    if (iconTasksClick().found) {
        claim_all()
        claim()
        clickAnyX()
    }
}
