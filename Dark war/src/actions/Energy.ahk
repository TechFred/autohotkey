#Requires AutoHotkey v2.0

O_energy_plus := image("energy_plus.bmp", 50, Regions.AllRegion)

energy() {
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    if (ImageFinderInstance.FindAnyImageObjects(true, 2000, O_energy_plus).found) {

        ;3 claims

        ClaimLoopOCR(5000, 5, Regions.events.main)
        iconPlayerClickBlind()
    }
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    clickAnyBack()
}
