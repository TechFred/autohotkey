#Requires AutoHotkey v2.0

O_expeditionChest := Image("expedition_chest.bmp", 100, Regions.AllRegion)
O_expedition_chest2 := Image("expedition_chest2.bmp", 100, Regions.AllRegion)

O_expedition_chest_group:=[
    O_expeditionChest,
    O_expedition_chest2
]

O_expeditionChestAnimation := Image("expedition_chest_animation.bmp", 50, Regions.AllRegion)

Expeditions() {
    if (ImageFinderInstance.LoopFindAnyImageObjects(4000, true, 200, 10, O_expedition_chest_group*).found) {

        loop 10 {
            if (ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 200, 10, O_expeditionChestAnimation).found) {
                LoggerInstance.Debug("Chest found")
                ClaimOCR(3000,,Regions.menus.bottom)
                Claim(4000, 1)
                Remove_Congrat()
                clickAnyBack()

            } else {
                LoggerInstance.Debug("No more chests -> Quitting")
                break
            }
        }
    }
    clickAnyBack()
    nbnotfound := 0

}
