#Requires AutoHotkey v2.0

combat(){
    if (iconCombatClick().found){
        ;Sleep (2000)
        ClaimLoopOCR()
        ;Remove_Congrat()
        clickAnyBack()
    }

}