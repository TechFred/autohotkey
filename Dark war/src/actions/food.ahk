#Requires AutoHotkey v2.0

    imagePaths := [
        "optimise_food.bmp",
        "optimise_food_2.bmp",
        "optimise_food_3.bmp",
        "optimise_food_4.bmp"
    ]

food(){
    ;region, tolerance := 0, clickDelay := 1000, doClick := true, loopDelay := 1000,  attempts := 5, paths*
    if (ImageFinderInstance.LoopFindAnyImage(Regions.AllRegion, 50, 3000, true, 250, 10, imagePaths*).found){
        LoggerInstance.Debug("food found")
    } else {
        LoggerInstance.Debug("food NOT found")
    }
}