#Requires AutoHotkey v2.0

O_energy_plus := image("energy_plus.bmp", 50, Regions.AllRegion)

energy() {
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    if (ImageFinderInstance.FindAnyImageObjects(true, 2000, O_energy_plus).found) {
        ClaimLoopOCR(5000, 5)
        iconPlayerClickBlind()
    }
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    clickAnyBack()
}
