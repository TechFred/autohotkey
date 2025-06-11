#Requires AutoHotkey v2.0

combat(){
    if (iconCombatClick().found){
        ;Sleep (2000)
        ClaimLoopOCR(2000,4)
        ;Remove_Congrat()
        clickAnyBack()
    }

}