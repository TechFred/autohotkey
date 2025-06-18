#Requires AutoHotkey v2.0

combat() {
    if (iconCombatClick().found) {
        MouseClick("left", Positions.combat.claim[1], Positions.combat.claim[2])
        Sleep(1000)
        MouseClick("left", Positions.combat.claim2[1], Positions.combat.claim2[2])
        Sleep(3000)
        Remove_Congrat()
        iconPlayerClickBlind(250)

        clickAnyBack()
    }

}
