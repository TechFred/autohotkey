#Requires AutoHotkey v2.0

combat(){
    if (iconCombatClick().found){
        Claim()
        Remove_Congrat()
        clickAnyBack()
    }

}