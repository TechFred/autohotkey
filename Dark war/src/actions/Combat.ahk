#Requires AutoHotkey v2.0

combat(){
    if (iconCombatClick().found){
        ClaimLoopOCR()
        ;Remove_Congrat()
        clickAnyBack()
    }

}