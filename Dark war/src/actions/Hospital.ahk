#Requires AutoHotkey v2.0

O_heal_btn := Image("heal.bmp", 80, Regions.AllRegion)
O_heal_selectall := Image("heal_selectall.bmp", 50, Regions.AllRegion)
O_heal_grayed := Image("heal_grayed.bmp", 50, Regions.AllRegion)
O_heal_0 := Image("heal_0.bmp", 50, Regions.AllRegion)
O_heal_alliance := Image("heal_alliance_help.bmp", 50, Regions.AllRegion)
O_speedup := Image("speedup.bmp", 50, Regions.AllRegion)

O_redcross := Image("red_cross_transblack.bmp", 50, Regions.icons.heal, TransBlack)

O_heal_figthers := Image("heal_done_figthers.bmp", 50, Regions.icons.heal)
O_heal_shooters := Image("heal_done_shooters.bmp", 50, Regions.icons.heal)
O_heal_riders := Image("heal_done_riders.bmp", 50, Regions.icons.heal)

Healdone := [
    O_heal_figthers,
    O_heal_shooters,
    O_heal_riders
]

HealDone_folder := LoadImagesFrom("heal_done", Regions.icons.heal)

Hospital(DoLoop := true, quantity := 60) {
    if Screens.mains.Healing.WaitForMatch() {
        LoggerInstance.Debug("Healing found")
        ;Healed := false
        i := 0
        y := 10

        ; Logique fonctionne mal avec les boomers. Ajout d'une condition pour attendre
        ; LoopFindAnyImageObjects(clickDelay := 1000, doClick := true, loopDelay := 1000, attempts := 5, imagesObjs*) {

        if !DoLoop {
            ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 1000, attempts := 10, O_heal_btn)
        }

        loop {
            if ImageFinderInstance.FindAnyImageObjects(1000, false, O_heal_btn).found {
                i := 0
                loop 10 {
                    LoggerInstance.Debug("Select All")
                    ImageFinderInstance.FindAnyImageObjects(500, true, O_heal_selectall)
                    if ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 10, 10, O_heal_grayed).found {
                        if ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 250, 10, O_heal_0).found {
                            ; Heal 60 troops
                            SendText(String(quantity))
                            Sleep(500)
                            Send("{Enter}")
                            Sleep(750)
                            ImageFinderInstance.FindAnyImageObjects(1000, true, O_heal_btn)
                            ImageFinderInstance.FindAnyImageObjects(2000, true, O_heal_alliance)
                            LoggerInstance.Debug("Healing in progress...")
                        } else {
                            ImageFinderInstance.FindAnyImageObjects(500, true, O_heal_selectall)
                        }

                        break
                    }

                }

                ; Parfois l'image est non trouvé, ni heal.bmp? Revoir la stratégie. Ajouter elseif si le alliane n'est pas cliqué.
                ; Pour le moment, pas nécessaire.
            } else if ImageFinderInstance.FindAnyImageObjects(1000, false, O_speedup).found {
                i := 0
                Sleep(1000)
            } else {
                i += 1
                Sleep(1000)
            }

        } until i > 600 || !DoLoop
        LoggerInstance.Debug("Healing done, i = " i)
        ExitHospital()
    }
}

HospitalStatus(quantity := 60) {

    if ImageFinderInstance.FindAnyImageObjects(2000, true, O_redcross).found {
        LoggerInstance.Debug("Redcross found - Clicking")
        Hospital(DoLoop := false, quantity)
    } else if ImageFinderInstance.FindAnyImageObjects(2000, true, HealDone_folder*).found {
        LoggerInstance.Debug("Healing done - Clicking")
        HospitalStatus()
    }

}

ExitHospital() {
    if Screens.mains.Healing.WaitForMatch(3000) {
        loop 10 {
            LoggerInstance.Debug("Exiting Hospital")
            iconPlayerClickBlind()
            Sleep(2000)
        } until !Screens.mains.Healing.WaitForMatch(250)
        LoggerInstance.Debug("Hospital exited")
    }

}

LoadImagesFrom(subfolder, iconRegion) {
    out := []
    fullPath := A_ScriptDir "\assets\images\" subfolder
    loop files fullPath "\*.bmp" {
        relPath := subfolder "\" A_LoopFileName
        out.Push(Image(relPath, 50, iconRegion))
    }
    return out
}


