#Requires AutoHotkey v2.0

Claim(ClickDelay := 1000, maxloop := 100) {

    LoggerInstance.Debug("Searching Claim")

    imagePaths := [
        "combat_claim_blue.bmp",
        "combat_claim.bmp",
        "claim.bmp",
        "gift_claim.bmp",
        "expedition_claim.bmp",
        "tasks_claim.bmp",
        "Energy_claim.bmp",
        "Events_claim.bmp",
        "Events_claim_2.bmp",
        "Levelup_claim.bmp", 
        "luckytoken_claim.bmp"
    ]
    j := 0
    i := 0
    loop {
        img := ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, 50, ClickDelay, true, 0, 2, imagePaths*)
        if (img.Found) {
            Remove_Congrat()
            i := 0
            j += 1
        } else {
            i += 1
        }

    } until (i > 10 or j > maxloop)

}

Claim_All(ClickDelay := 3000) {
    LoggerInstance.Debug("Searching Claim_All")

    imagePaths := [
        "gifts_claim_all.bmp",
        "daily_task_claim_all.bmp",
        "battlerewards_claim_all.bmp"
    ]

    i := 0
    loop {
        img := ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, 50, 3000, true, 50, 1, imagePaths*)

        if (img.Found) {
            Remove_Congrat()
            i := 0
        } else {
            i += 1
        }

    } until (i > 10)

    ;ImageFinderInstance.LoopFindImage("gifts_claim_all.bmp", Regions.AllRegion, tolerance := 50, clickDelay := 1000, doClick := false, loopDelay := 500, attempts := 5)

}

Claim_VIP() {

}

Claim_Pack() {

}

Find_Congrat(doClick := false) {
    LoggerInstance.Debug("Searching Congrat")
    return ImageFinderInstance.LoopFindImage("claim_congrat.bmp", Regions.AllRegion, 50, 3000, doClick, 50, 1)

}

Remove_Congrat() {
    congrat := Find_Congrat()
    loop 10 {
        if (congrat.Found) {
            LoggerInstance.Debug("Congrat found")
            congrat := Find_Congrat(true)
        } else {
            LoggerInstance.Debug("Congrat not found")
            break
        }
    }

}
