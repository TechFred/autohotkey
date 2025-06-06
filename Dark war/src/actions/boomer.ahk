#Requires AutoHotkey v2.0


O_BoomerCancel := Image("cancel.bmp", 50, Regions.AllRegion)
O_WorldShelterIcon := Image("world_shelter_icon.bmp", 50, Regions.AllRegion)
O_Boomer_BW := Image("boomers_BW.bmp", 50, Regions.AllRegion)
O_BoomerGroup := Image("group.jpg", 50, Regions.AllRegion)
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

boomers() {
    if (goToWorld() = SCREEN_WORLD) {

        i := 0

        loop {
            if GetEnergy() {
                LoggerInstance.Info("Out of energy -> quitting")
                ExitBoomers
                return
            }
            ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_BoomerCancel)
            centerShelter()
            ;ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_WorldShelterIcon)
            iconHelpClick()

            if (getCurrentScreen() != SCREEN_WORLD) {
                LoggerInstance.warn("Error - not in world")
                return
            }

            iconLensClick()
            ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_Boomer_BW)
            ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_BoomerSearch)
            ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, O_BoomerGroup)

            loop {
                if !(ImageFinderInstance.LoopFindAnyImageObjects(300, true, 50, 5, ImagesAPC1*).found) {
                    i += 1
                    break
                }

                if ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 50, 5, ImagesMarches*).found {
                    Sleep(60000)
                    i := 0
                    break
                } else {
                    i += 1
                    if (i > maxloop OR GetEnergy()) {
                        LoggerInstance.Info("Bommer loop: " i " Or out of energy -> Quitting")
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
    goToShelter()
}
