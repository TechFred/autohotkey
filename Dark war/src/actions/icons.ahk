#Requires AutoHotkey v2.0

iconHelp := "help.bmp"
iconHelp_2 := "help_2.bmp"
iconHelp_3 := "help_3.bmp"

iconEscort := "escort.bmp"
iconOptimise := "optimise.bmp"
iconWorldShelter := "world_shelter_icon.bmp"
iconCombat := "combat.bmp"
iconAlliance := "Alliance.bmp"
iconPackShop := "claim.bmp"
iconPremiumCenter := "premium_icon.bmp"

;liconBattleRewards := "combat_claim.bmp"

iconPlayer := "switch_playericon.bmp"
iconBack := "btn_return.bmp"
iconVip := "gift_claim.bmp"
iconLens := "lens.bmp"

O_iconHeal := Image("Heal.bmp", 50, Regions.icons.heal)
O_optimise_reddot := Image("Reddot.bmp", 50, Regions.icons.optimise)
O_iconTasks := Image("daily_task.bmp", 50, Regions.icons.tasks)
;O_iconbattlerewards := Image("battle_rewards_icon.bmp", 50, Regions.icons.battle_rewards)
O_iconbattlerewards := Image("battle_rewards_icon_transblack.bmp", 25, Regions.menus.left, TransBlack)

O_iconCombat := Image("combat.bmp", 50, Regions.icons.combat)
O_iconCombat2 := Image("combat2.bmp", 50, Regions.icons.combat)

O_icontruck := Image("escort_truck.bmp", 100, Regions.menus.left)
;lO_icontruck_BattleRewards := Image("escort_truck.bmp", 100, Regions.icons.battle_rewards)

O_iconEvents_reddot := Image("Events_reddot.bmp", 50, Regions.icons.events)
O_iconEvents := Image("Events_new.bmp", 50, Regions.icons.events)

iconHelpClick() {

    imagePaths := [
        iconHelp,
        iconHelp_2,
        iconHelp_3
    ]

    return ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, 50, 1000, true, 0, 2, imagePaths*)
}

iconHealClick() {

    return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 20, 10, O_iconHeal)
}

iconAllianceClick() {
    if goToShelter() != SCREEN_SHELTER {
        LoggerInstance.Warn("Error, Shelter not found - Quitting")
        return
    }

    return ImageFinderInstance.LoopFindImage(iconAlliance, Regions.icons.Alliance, 50, 1000, true, 500, 5)
}

iconEscortClick() {

    if goToShelter() != SCREEN_SHELTER {
        LoggerInstance.Warn("Error, Shelter not found - Quitting")
        return
    }

    return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, O_icontruck)
}

iconOptimiseClick() {

    O_reddot_transblack_local := O_reddot_transblack.Clone()
    O_reddot_transblack_local.region := Regions.icons.optimise

    imageObjects := [
        O_reddot_transblack_local,
        O_optimise_reddot
    ]

    if goToShelter() != SCREEN_SHELTER {
        LoggerInstance.Warn("Error, Shelter not found - Quitting")
        return
    }
    res := ImageFinderInstance.LoopFindAnyImageObjects(1000, false, 500, 5, imageObjects*)
    if res.found = true{
        MouseClick("left", res.x, res.y+10)
        sleep (1000)
    }

    return res
}

iconCombatClick() {

    imageObjects := [
        O_iconCombat,
        O_iconCombat2
    ]

    if goToShelter() != SCREEN_SHELTER {
        LoggerInstance.Warn("Error, Shelter not found - Quitting")
        return
    }
    return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, imageObjects*)
}

iconPackShopClick() {
    return ImageFinderInstance.LoopFindImage(iconPackShop, Regions.icons.pack_shop, 50, 1000, true, 500, 5)
}

iconPremiumCenterClick() {
    return ImageFinderInstance.LoopFindImage(iconPremiumCenter, Regions.icons.premium_center, 50, 2000, true, 500, 5)
}

iconEventsClick() {

        imageObjects := [
        O_iconevents,
        O_iconEvents_reddot
    ]

    return ImageFinderInstance.LoopFindAnyImageObjects(2000, true, 500, 5, imageObjects*)
}

iconBattleRewardsClick() {

    if goToShelter() != SCREEN_SHELTER {
        LoggerInstance.Warn("Error, Shelter not found - Quitting")
        return
    }

    return ImageFinderInstance.LoopFindAnyImageObjects(1000, true, 500, 5, O_iconbattlerewards)
}



iconPlayerClick() {
    return ImageFinderInstance.LoopFindImage(iconPlayer, Regions.icons.player, 50, 1000, true, 500, 5)
}
iconPlayerClickBlind(DelayClick := 2000) {
    ClickCenter(Regions.icons.player, DelayClick)
}

iconHeroesClickBlind(DelayClick := 2000) {
    ClickCenter(Regions.icons.heroes, DelayClick)
}

iconVipClick() {
    return ImageFinderInstance.LoopFindImage(iconVip, Regions.AllRegion, 50, 1000, true, 500, 5)
}

iconLensClick() {
    if (goToWorld() = SCREEN_WORLD) {
        ClickCenter(Regions.icons.lens, 2000)
    }

}
