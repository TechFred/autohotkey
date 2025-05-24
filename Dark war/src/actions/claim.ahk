#Requires AutoHotkey v2.0

Claim() {

    LoggerInstance.Debug("Searching Claim")

    imagePaths := [
        "combat_claim_blue.bmp",
        "combat_claim.bmp",
        "claim.bmp",
        "gift_claim.bmp",
        "expedition_claim.bmp"

    ]

    i := 0
    loop {
        img := ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5, imagePaths*)
        if (img.Found) {
            Remove_Congrat()
            i := 0
        } else {
            i += 1
            Sleep(500)
        }

    } until (i > 10)

}

Claim_All() {
    LoggerInstance.Debug("Searching Claim_All")

    imagePaths := [
        "gifts_claim_all.bmp",
        "daily_task_claim_all.bmp"
    ]

    i := 0
    loop {
        img := ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, tolerance := 50, clickDelay := 3000, doClick := true, loopDelay := 500, attempts := 5, imagePaths*)

        if (img.Found) {
            Remove_Congrat()
            i := 0
        } else {
            i += 1
            Sleep(500)
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
    return ImageFinderInstance.LoopFindImage("claim_congrat.bmp", Regions.AllRegion, tolerance := 50, clickDelay := 1000, doClick := false, loopDelay := 500, attempts := 5)

}

Remove_Congrat() {
    congrat := Find_Congrat()
    loop 10 {
        if (congrat.Found) {
            LoggerInstance.Debug("Congrat found")
            congrat := Find_Congrat(true)
            sleep(3000)
        } else {
            LoggerInstance.Debug("Congrat not found")
            break
        }
    }

}
