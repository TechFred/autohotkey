#Requires AutoHotkey v2.0

; Icon paths
worldShelterIcon := "world_shelter_icon.bmp"
worldIcon := "world.bmp"
shelterIcon := "shelter.bmp"
AndroidIcon := "crash_darkwar_icon.bmp"

world_shelter_icon_2 := Image("world_shelter_icon_2.bmp", 100, Regions.AllRegion)

; Define screen state constants
global SCREEN_SHELTER := "Shelter"
global SCREEN_WORLD := "World"
global SCREEN_UNKNOWN := "Unknown"
global SCREEN_ANDROID := "Android"

getCurrentScreen() {
    centerShelter()

    LoggerInstance.debug("Detecting current screen")
    if (ImageFinderInstance.LoopFindImage(worldIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5).found) {
        LoggerInstance.debug("Detected: shelter screen")
        return SCREEN_SHELTER

    } else if (ImageFinderInstance.LoopFindImage(shelterIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5).found) {
        LoggerInstance.debug("Detected: world screen")
        return SCREEN_WORLD
    } else if (ImageFinderInstance.LoopFindImage(AndroidIcon, Regions.AllRegion, 50, 5000, false, 50, 2).found) {
        LoggerInstance.debug("Detected: Android screen")
        return SCREEN_ANDROID
    } else {
        LoggerInstance.debug("Detected: unknown screen")
        return SCREEN_UNKNOWN
    }
}

goToWorldOCR() {
    centerShelter()
    InWorld := false
    LoggerInstance.debug("Navigating to world screen")
    loop 5 {
        if Screens.shelter.world.WaitForMatch(1000) {
            InWorld := true
            break
        } else {
            LoggerInstance.debug("Not in world clicking on world icon")
            ClickCenter(Regions.icons.world_Shelter, 5000)
        }
        sleep (2000)
    } until InWorld

    return InWorld
}


goToShelterOCR() {
    centerShelter()
    InShelter := false
    LoggerInstance.debug("Navigating to Shelter screen")
    loop 5 {
        if Screens.shelter.Shelter.WaitForMatch(1000) {
            InShelter := true
            break
        } else {
            LoggerInstance.debug("Not in Shelter clicking on world icon")
            ClickCenter(Regions.icons.world_Shelter, 5000)
        }
        sleep (2000)
    } until InShelter

    return InShelter
}


goToWorld() {
    centerShelter()
    LoggerInstance.debug("Navigating to world screen")
    ImageFinderInstance.LoopFindImage(worldIcon, Regions.icons.world_Shelter, 50, 5000, true, 50, 5)
    return getCurrentScreenOCR()
}

goToShelter() {
    centerShelter()
    LoggerInstance.debug("Navigating to shelter screen")
    ImageFinderInstance.LoopFindImage(shelterIcon, Regions.icons.world_Shelter, 50, 5000, true, 50, 5)
    return getCurrentScreen()
}

centerShelter() {
    LoggerInstance.debug("Attempting to center on shelter")
    return ImageFinderInstance.LoopFindAnyImageObjects(3000, true, 20, 5, world_shelter_icon_2).found
}

getCurrentScreenOCR() {
    ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0)

    ; Search titles
    ocrOptionsRegion(ocrOptions, Regions.menus.top)
    Title := OCR.FromWindow(winTitle, MapToObject(ocrOptions))

    ; search World-Shelter
    ocrOptionsRegion(ocrOptions, Regions.icons.world_Shelter)
    WorldShelter := OCR.FromWindow(winTitle, MapToObject(ocrOptions))

    ; search Main
    ocrOptionsRegion(ocrOptions, Regions.Events.main)
    Main := OCR.FromWindow(winTitle, MapToObject(ocrOptions))

    ; search Bottom
    ocrOptionsRegion(ocrOptions, Regions.menus.bottom)
    Bottom := OCR.FromWindow(winTitle, MapToObject(ocrOptions))

    ocrResults := Map(
        "title", Title,
        "world_Shelter", WorldShelter,
        "main", Main,
        "bottom", Bottom,
        "custom", Main ; Comment skip
    )

    FlatScreens := GetAllScreensFlat()

    Isdetected := false
    for s in FlatScreens {
        regionKey := s.RegionKey
        if regionKey && ocrResults.Has(regionKey) {
            if s.IsActive(ocrResults[regionKey]) {
                LoggerInstance.debug("Detected screen: " s.Name)
                Isdetected := true
                return s
            }
        } else {
            LoggerInstance.debug("Unknown or unmatched region for screen: " s.Name "-" s.RegionKey)
        }
    }

    if !(Isdetected) {
        LoggerInstance.debug("Detected: No screen found")
        LoggerInstance.debug("Title -" Title.Text)
        LoggerInstance.debug("Main -" Main.Text)
        LoggerInstance.debug("WorldShelter -" WorldShelter.Text)
        return Isdetected
    }
}
