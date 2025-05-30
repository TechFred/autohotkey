#Requires AutoHotkey v2.0

; Icon paths
worldShelterIcon := "world_shelter_icon.bmp"
worldIcon := "world.bmp"
shelterIcon := "shelter.bmp"
AndroidIcon := "crash_darkwar_icon.bmp"

world_shelter_icon_2 := Image("world_shelter_icon_2.bmp", 100, Regions.AllRegion)

; Define screen state constants
global SCREEN_SHELTER := "shelter"
global SCREEN_WORLD := "world"
global SCREEN_UNKNOWN := "unknown"
global SCREEN_ANDROID := "android"

getCurrentScreen() {
    centerShelter()

    loggerInstance.debug("Detecting current screen")

    if (ImageFinderInstance.LoopFindImage(worldIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5).found) {
        loggerInstance.debug("Detected: shelter screen")
        return SCREEN_SHELTER

    } else if (ImageFinderInstance.LoopFindImage(shelterIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5).found) {
        loggerInstance.debug("Detected: world screen")
        return SCREEN_WORLD
    } else if (ImageFinderInstance.LoopFindImage(AndroidIcon, Regions.AllRegion, 50, 5000, false, 50, 5).found) {
        loggerInstance.debug("Detected: Android screen")
        return SCREEN_ANDROID
    } else {
        loggerInstance.debug("Detected: unknown screen")
        return SCREEN_UNKNOWN
    }
}

goToWorld() {
    centerShelter()
    loggerInstance.debug("Navigating to world screen")
    ImageFinderInstance.LoopFindImage(worldIcon, Regions.icons.world_Shelter, 50, 5000, true, 50, 5)
    return getCurrentScreen()
}

goToShelter() {
    centerShelter()
    loggerInstance.debug("Navigating to shelter screen")
    ImageFinderInstance.LoopFindImage(shelterIcon, Regions.icons.world_Shelter, 50, 5000, true, 50, 5)
    return getCurrentScreen()
}

centerShelter() {
    loggerInstance.debug("Attempting to center on shelter")
    return ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 20, 5, world_shelter_icon_2).found
}
