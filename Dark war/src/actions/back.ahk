#Requires AutoHotkey v2.0

btn_return := "btn_return.bmp"
btn_return_white := "btn_return_white.bmp"
btn_return_white_2 := "btn_return_white_2.bmp"



Click_brownback(){
    LoggerInstance.Debug("clicking brown back Button")
    img := ImageFinderInstance.LoopFindImage(btn_return, Regions.icon.back, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5)
    return img.found
}

Click_whiteback(){
    LoggerInstance.Debug("clicking white back Button")
    img := ImageFinderInstance.LoopFindImage(btn_return_white, Regions.icon.back, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5)
    return img.found
}

Click_back(){
    LoggerInstance.Debug("clicking any back Button")

    imagePaths := [
        btn_return,
        btn_return_white,
        btn_return_white_2,

    ]

    img := ImageFinderInstance.LoopFindAnyImage(Regions.icon.back, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5, imagePaths)
    return img.found

}