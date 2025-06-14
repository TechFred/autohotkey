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

ClaimOCR(ClickDelay := 1000, LoopDelay := 5000, Region := Regions.AllRegion) {
    LoggerInstance.Debug("Searching Claim OCR")
    match := WaitFindText("(?i)\bclaim\b", Map(
        "Click", true,
        "ClickDelay", ClickDelay,
        "LoopDelay", LoopDelay,
        "Region", Region,
        "ocrOptions", Map("lang", "en-us", "scale", 3, "grayscale", 0, "mode", 4, "casesense", 0)
    ))

    if !(match) {
        match := WaitFindText("(?i)\bclaim\b", Map(
            "Click", true,
            "ClickDelay", ClickDelay,
            "LoopDelay", 1000,
            "Region", Region,
            "ocrOptions", Map("lang", "en-us", "scale", 5, "grayscale", 0, "mode", 4, "casesense", 0)
        ))
    }

    ;ocrOptions := Map("lang", "en-us", "scale", 3, "grayscale", 0, "casesense", 0, "mode", 4)
    RemoveCongratOCR(, LoopDelay := 1)

    return match
}

ClaimAllOCR(ClickDelay := 3000, Region := Regions.AllRegion, ocrOptions := Map("scale", 3, "grayscale", 1, "mode", 4, "casesense", 0)) {
    LoggerInstance.Debug("Searching Claim All OCR")
    match := WaitFindText("(?i)claim.all", Map(
        "Click", true,
        "ClickDelay", ClickDelay,
        "LoopDelay", 3000,
        "Region", Region,
        "ocrOptions", ocrOptions
    ))

    if (match) {
        RemoveCongratOCR()
        RemoveCongratOCR(, LoopDelay := 1)
        RemoveCongratOCR(, LoopDelay := 1)
    }

}

RemoveCongratOCR(clickDelay := 2000, LoopDelay := 3000, Region := Regions.AllRegion) {
    LoggerInstance.Debug("Remove Congrat OCR")
    WaitFindText("(?i)Congrat", Map(
        "Click", true,
        "ClickDelay", clickDelay,
        "LoopDelay", LoopDelay,
        "Region", Regions.AllRegion
    ))
}

__OCR(text) {
    WaitFindText(text, Map(
        "Click", true,
        "ClickDelay", 2000,
        "LoopDelay", 8000,
        "Region", Regions.AllRegion,
        "ocrOptions", Map("scale", 1)
    ))
}

ClaimLoopOCR(ClickDelay := 1000, LoopCount := 100, Region := Regions.AllRegion) {
    LoggerInstance.debug("Starting ClaimLoopOCR: " LoopCount)
    j := 0
    i := 0
    loop {
        match := ClaimOCR(ClickDelay, 1000, Regions.AllRegion)
        if (match) {

            i := 0
        } else {
            i += 1
        }
        j += 1
    } until (i >= 3 or j > LoopCount)
    LoggerInstance.debug("Ending ClaimLoopOCR" " i:" i " j:" j)

}
