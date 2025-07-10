#Requires AutoHotkey v2.0

O_BoomerCancel := Image("cancel.bmp", 50, Regions.AllRegion)
O_WorldShelterIcon := Image("world_shelter_icon.bmp", 50, Regions.AllRegion)
O_Boomer_BW := Image("boomers_BW.bmp", 50, Regions.AllRegion)
O_BoomerGroup := Image("Boomer_teamup.bmp", 50, Regions.AllRegion)
O_BoomerSearch := Image("search.jpg", 50, Regions.AllRegion)

;march
O_March_1 := Image("March.jpg", 50, Regions.AllRegion)
O_March_2 := Image("March_2.bmp", 50, Regions.AllRegion)
O_March_3 := Image("March_3.bmp", 50, Regions.AllRegion)

ImagesMarches := [O_March_1, O_March_2, O_March_3]

;APC
O_APC1_1 := Image("APC1.bmp", 50, Regions.AllRegion)
O_APC1_2 := Image("APC1_2.bmp", 50, Regions.AllRegion)

ImagesAPC1 := [O_APC1_1, O_APC1_2]

maxloop := 60

iconLensClick() {
    if goToWorldOCR() {
        ClickCenter(Regions.icons.lens, 2000)
    } else {
        LoggerInstance.warn("Error, not in world")
    }

}

boomers() {
    goToWorldOCR()
    if (Screens.shelter.world.WaitForMatch(5000)) {

        i := 0

        loop {
            if Screens.mains.GetEnergy.WaitForMatch(200) {
                LoggerInstance.Info("Out of energy -> quitting")
                ExitBoomers()
                return
            }

            WaitFindText("(?i)Cancel", Map(
                "Click", true,
                "ClickDelay", 2000,
                "LoopDelay", 250,
                "Region", Regions.events.main,
                "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
            ))
            ;ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_BoomerCancel)
            centerShelter()
            ;ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_WorldShelterIcon)
            iconHelpClick()
            HospitalStatus()

            if (!Screens.shelter.world.WaitForMatch(2000)) {
                LoggerInstance.warn("Error - not in world")
                ExitBoomers()
                return
            }

            iconLensClick()

            if !(WaitFindText("(?i)Boom.r", Map(
                "Click", true,
                "ClickDelay", 2000,
                "LoopDelay", 250,
                "Region", Regions.events.main,
                "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
            ))) {

                WaitFindText("(?i)Rally", Map(
                    "Click", true,
                    "ClickDelay", 2000,
                    "LoopDelay", 1000,
                    "Region", Regions.events.main,
                    "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
                ))

                WaitFindText("(?i)Bo.m.r", Map(
                    "Click", true,
                    "ClickDelay", 2000,
                    "LoopDelay", 250,
                    "Region", Regions.events.main,
                    "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
                ))

            }

            WaitFindText("(?i)Search", Map(
                "Click", true,
                "ClickDelay", 2000,
                "LoopDelay", 250,
                "Region", Regions.events.bottom,
                "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
            ))

            ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_BoomerGroup)

            loop {
                if !(ImageFinderInstance.LoopFindAnyImageObjects(300, true, 50, 5, ImagesAPC1*).found) {
                    i += 1
                    break
                }

                ;if ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, ImagesMarches*).found
                ocrOptions := Map("lang", "en-us", "scale", 3, "grayscale", 0, "casesense", 0, "mode", 4)
                if (WaitFindText("(?i)\bMarch\b", Map(
                    "Click", true,
                    "ClickDelay", 2000,
                    "LoopDelay", 50,
                    "Region", Regions.AllRegion,
                    "ocrOptions", ocrOptions
                ))) {

                    ; Loop for 60 secondes
                    startTime := A_TickCount  ; Get current time in milliseconds
                    loop {
                        HospitalStatus()
                        iconHelpClick()
                        Sleep (1000)  ; To avoid too much loops
                    } until (A_TickCount - startTime > 60000)
                    i := 0
                    break
                } else {
                    i += 1
                    if (i > maxloop OR GetEnergyOCR()) {
                        LoggerInstance.Info("Bommer loop: " i " Or out of energy -> Quitting")
                        if (i > maxloop) {
                            TakeScreenshot()
                            LoggerInstance.warn("Screenshot taken, error")
                        }
                        ExitBoomers()
                        return
                    }
                }
                Sleep(5000)

            }
        }

    }
}
ExitBoomers() {
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    clickAnyBack()
    goToShelterOCR()
}

GetEnergyOCR() {

    return WaitFindText("(?i)Get Energy", Map(
        "Click", false,
        "ClickDelay", 2000,
        "LoopDelay", 250,
        "Region", Regions.events.main,
        "ocrOptions", Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 1)
    ))
}
