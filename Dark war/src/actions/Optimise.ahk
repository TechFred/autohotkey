#Requires AutoHotkey v2.0

O_residentstatus := Image("optimise_resident_status.bmp", 50, Regions.AllRegion)
O_optimise_btn := Image("optimise_btn.bmp", 50, Regions.AllRegion)

optimise() {
    if iconOptimiseClick().found {

        if WaitFindText("(?i)Optimize", Map(
            "Click", true,
            "ClickDelay", 4000,
            "LoopDelay", 4000,
            "Region", Regions.events.main,
            "ocrOptions", Map("scale", 1)
        )){
            iconPlayerClickBlind()
            iconPlayerClickBlind()
            iconPlayerClickBlind()
            clickAnyBack()
        }

        /*
        if ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 200, 10, O_residentstatus).found {
            ImageFinderInstance.LoopFindAnyImageObjects(4000, true, 200, 10, O_optimise_btn)

        }
            */
    }
}
