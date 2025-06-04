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

    ocrResults := Map(
        "title", Title,
        "world_Shelter", WorldShelter,
        "main", Main
    )

    Isdetected := false
    for s in Screens {
        regionKey := s.RegionKey
        if regionKey && ocrResults.Has(regionKey) {
            if s.IsActive(ocrResults[regionKey]) {
                loggerInstance.debug("Detected screen: " s.Name)

                break
            }
        } else {
            loggerInstance.debug("Unknown or unmatched region for screen: " s.Name)
        }
    }

    if !(Isdetected) {
        loggerInstance.debug("Detected: No OCR found")
        loggerInstance.debug("Title -" title.Text)
        loggerInstance.debug("Main -" Main.Text)
        loggerInstance.debug("WorldShelter -" WorldShelter.Text)
    }

    /*
    for screen in Screens {
        if screen.IsActive(OCR.FromWindow(winTitle, MapToObject(Map("scale", 2, "lang", "en-us")))) {
            loggerInstance.debug("Detected: " screen.Name)
            break
        }
    }
    */
    /*
    ;Search for strings
    searchOptions := Map("IgnoreLinebreaks", true, "SearchFunc", RegExMatch)
    
    if (found := Title.FindString("(?i)P.emium Center", searchOptions)) {
        loggerInstance.debug("Detected: (?i)P..mium Center")
    } else if (found := Title.FindString("(?i)Events", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Events")
    } else if (found := Title.FindString("(?i)Survivor P.ofile", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Survivor P.ofile")
    } else if (found := WorldShelter.FindString("(?i)World", searchOptions)) {
        loggerInstance.debug("Detected: (?i)World")
    } else if (found := WorldShelter.FindString("(?i)Shelter", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Shelter")
    } else if (found := Main.FindString("(?i)Logged", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Logged")
    } else if (found := Main.FindString("(?i)Applications syst", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Applications syst")
    } else if (found := Main.FindString("(?i)Guy", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Guy")
    } else if (found := Title.FindString("(?i)Hero List", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Hero List")
    } else if (found := Title.FindString("(?i)VIP", searchOptions)) {
        loggerInstance.debug("Detected: (?i)VIP")
    } else if (found := Title.FindString("(?i)Alliance\b", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Alliance")
    } else if (found := Main.FindString("(?)Team Details", searchOptions)) {
        loggerInstance.debug("Detected: (?)Team Details")
    } else if (found := Main.FindString("(?i)Alliance Techs", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Alliance Techs")
    } else if (found := Title.FindString("(?i)Gifts\b", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Gifts\b")
    }else if (found := Title.FindString("(?i)Adventure", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Adventure")
    }else if (found := Title.FindString("(?i)Daily Tasks", searchOptions)) {
        loggerInstance.debug("Detected: (?i)Daily Tasks")
    }else {
        loggerInstance.debug("Detected: No OCR found")
        loggerInstance.debug("Title -" title.Text)
        loggerInstance.debug("Main -" Main.Text)
        loggerInstance.debug("WorldShelter -" WorldShelter.Text)
    
    }
    
    */

    loggerInstance.debug("Detecting current screen")
    if (ImageFinderInstance.LoopFindImage(worldIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5).found) {
        loggerInstance.debug("Detected: shelter screen")
        return SCREEN_SHELTER

    } else if (ImageFinderInstance.LoopFindImage(shelterIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5).found) {
        loggerInstance.debug("Detected: world screen")
        return SCREEN_WORLD
    } else if (ImageFinderInstance.LoopFindImage(AndroidIcon, Regions.AllRegion, 50, 5000, false, 50, 2).found) {
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


