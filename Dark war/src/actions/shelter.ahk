#Requires AutoHotkey v2.0

world_shelter_icon := "world_shelter_icon.bmp"
word_icon := "world.bmp"
shelter_icon := "shelter.bmp"

getcurrentscreen() {
    loggerintstance.debug("Get screen region")
    if (ImageFinderInstance.LoopFindImage(word_icon, Regions.icon.word_icon, tolerance := 50, clickDelay := 1000, doClick := false, loopDelay := 50, attempts := 5).found) {
        loggerintstance.debug("shelter")
        return "shelter"
    } else if (ImageFinderInstance.LoopFindImage(shelter_icon, Regions.icon.word_icon, tolerance := 50, clickDelay := 1000, doClick := false, loopDelay := 50, attempts := 5).found) {
        loggerintstance.debug("world")
        return "world"
    } else {
        loggerintstance.debug("Unknown")
        return "unknown"
    }
}

goto_world() {
    loggerintstance.debug("goto world")
    ImageFinderInstance.LoopFindImage(word_icon, Regions.icon.word_icon, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5)
    return getcurrentscreen()
}

goto_shelter() {
    loggerintstance.debug("goto shelter")
    ImageFinderInstance.LoopFindImage(shelter_icon, Regions.icon.word_icon, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5)
    return getcurrentscreen()
}

shelter_center() {
    loggerintstance.debug("center shelter")
    found := false
    if (getcurrentscreen() = "world") {
        loggerintstance.debug("center shelter incon found")
        found := ImageFinderInstance.LoopFindImage(world_shelter_icon, Regions.AllRegion, tolerance := 50, clickDelay := 1000, doClick := true, loopDelay := 50, attempts := 5).found
    }
    return found

}
