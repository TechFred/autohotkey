#Requires AutoHotkey v2.0

O_expeditionChest := Image("expedition_chest.bmp", 100, Regions.AllRegion)
O_expeditionChestAnimation := Image("expedition_chest_animation.bmp", 50, Regions.AllRegion)

Expeditions() {
    if (ImageFinderInstance.LoopFindAnyImageObjects(4000, true, 200, 10, O_expeditionChest).found) {

        loop 10 {
            if (ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 200, 10, O_expeditionChestAnimation).found) {
                LoggerInstance.Debug("Chest found")
                Claim(4000, 1)
                Remove_Congrat()

            } else {
                LoggerInstance.Debug("No more chests -> Quitting")
                break
            }
        }
    }
    clickAnyBack()
    nbnotfound := 0

}
