#Requires AutoHotkey v2.0

; Image paths
btnReturn := "btn_return.bmp"
btnReturnWhite := "btn_return_white.bmp"
btnReturnWhite2 := "btn_return_white_2.bmp"

exitDailyTask := "daily_task_exit.bmp"
exitEvent := "splash_event_x.bmp"
exitGuy := "splash_guy_x.bmp"
exitGeneric := "splash_x.bmp"

;images objects
O_btnReturn := Image(btnReturn, 25, Regions.icons.back)
O_btnReturnWhite := Image(btnReturnWhite, 25, Regions.icons.back)
O_btnReturnWhite2 := Image(btnReturnWhite2, 25, Regions.icons.back)

O_exitDailyTask := image(exitDailyTask, 25, Regions.AllRegion)
O_exitEvent := image(exitEvent, 25, Regions.AllRegion)
O_exitGuy := image(exitGuy, 25, Regions.AllRegion)
O_exitGeneric := image(exitGeneric, 25, Regions.AllRegion)
O_TransblackX := image("transblack_x.bmp", 10, Regions.AllRegion, "TransBlack")
O_Task_x := image("task_x.bmp", 20, Regions.AllRegion, "TransBlack")


; Click individual back buttons
clickBrownBack() {
    LoggerInstance.Debug("Clicking brown back button")
    result := ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 0, 5, O_btnReturn)
    return result.found
}

clickWhiteBack() {
    LoggerInstance.Debug("Clicking white back button")
    result := ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 0, 5, O_btnReturnWhite2)
    return result.found
}

; Click any back button (composite function)
clickAnyBack() {
    LoggerInstance.Debug("Clicking any back button")

    ImagesObjects := [
        O_btnReturn,
        O_btnReturnWhite,
        O_btnReturnWhite2
    ]

    result := ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 0, 5, ImagesObjects*)
    ;result := ImageFinderInstance.LoopFindAnyImage(Regions.icons.back, tolerance := 50, clickDelay := 3000, doClick := true, loopDelay := 100, attempts := 5, imagePaths*)
    return result.found
}

; Click any X-style exit button
clickAnyX() {
    LoggerInstance.Debug("Clicking any X/exit button")

    ImagesObjects := [
        O_TransblackX,
        O_exitDailyTask,
        O_exitEvent,
        O_exitGuy,
        O_exitGeneric,
        O_Task_x
    ]
    result := ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 0, 5, ImagesObjects*)
    ;result := ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, tolerance := 50, clickDelay := 3000, doClick := true, loopDelay := 100, attempts := 5, imagePaths*)
    return result.found
}

ClickTransblackX() {

    result := ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 100, 5, O_TransblackX)

}
