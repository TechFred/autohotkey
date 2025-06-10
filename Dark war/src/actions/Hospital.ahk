#Requires AutoHotkey v2.0

O_heal_btn := Image("heal.bmp", 80, Regions.AllRegion)
O_heal_selectall := Image("heal_selectall.bmp", 50, Regions.AllRegion)
O_heal_grayed := Image("heal_grayed.bmp", 50, Regions.AllRegion)
O_heal_0 := Image("heal_0.bmp", 50, Regions.AllRegion)
O_heal_alliance := image("heal_alliance_help.bmp", 50, Regions.AllRegion)
O_speedup := image("speedup.bmp", 50, Regions.AllRegion)

Hospital() {
    if ImageFinderInstance.FindAnyImageObjects(1000, false, O_heal_btn).found {
        LoggerInstance.Debug("Healing found")
        Healed := false
        i := 0
        loop {
            if ImageFinderInstance.FindAnyImageObjects(1000, false, O_heal_btn).found {

                loop 10 {
                    LoggerInstance.Debug("Select All")
                    imageFinderInstance.FindAnyImageObjects(500, true, O_heal_selectall)
                    if ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 10, 10, O_heal_grayed).found {
                        ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 250, 10, O_heal_0)

                        ; Heal 60 troops
                        SendText("60")
                        Sleep(500)
                        Send("{Enter}")
                        Sleep(750)
                        ImageFinderInstance.FindAnyImageObjects(1000, true, O_heal_btn)
                        ImageFinderInstance.FindAnyImageObjects(2000, true, O_heal_alliance)
                        LoggerInstance.Debug("Healing in progress...")
                        break
                    }

                }

                ; Parfois l'image est non trouvé, ni heal.bmp? Revoir la stratégie. Ajouter elseif si le alliane n'est pas cliqué.
                ; Pour le moment, pas nécessaire. 
            } else if ImageFinderInstance.FindAnyImageObjects(1000, false, O_speedup).found {
                i := 0
                Sleep(2000)
            } else {
                i += 1
            }

        } until i > 50
        LoggerInstance.Debug("Healing done, i = " i)
        ExitApp

    }
}
