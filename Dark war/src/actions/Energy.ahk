#Requires AutoHotkey v2.0

O_energy_plus := image("energy_plus.bmp", 50, Regions.AllRegion)

energy() {
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    if (ImageFinderInstance.FindAnyImageObjects(true, 2000, O_energy_plus).found) {
        claim(5000, 2)
        clickAnyX()
    }
    iconPlayerClickBlind()
    iconPlayerClickBlind()
    clickAnyBack()
}
