#Requires AutoHotkey v2.0

class Screen {
    Region := [0, 0, 0, 0]
    Name := ""
    Regex := ""
    searchOptions := MapToObject(Map("IgnoreLinebreaks", true, "SearchFunc", RegExMatch))

    __New(Name, RegionKey, Region, Regex := "", searchOptions := "") {
        this.Name := Name
        this.Region := Region
        this.RegionKey := RegionKey
        this.Regex := Regex
        this.H := Region[4] - Region[2]
        this.W := Region[3] - Region[1]

        if IsObject(searchOptions)
            this.searchOptions := searchOptions
    }

    XYWH() {
        return Map(
            "x", this.Region[1],
            "y", this.Region[2],
            "w", this.W,
            "h", this.H
        )
    }

    IsActive(OCRResultObj) {
        try {
            return !!OCRResultObj.FindString(this.Regex, this.searchOptions)
        } catch {
            return false
        }
    }

    Find(LoopDelay := 8000, ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0)) {
        OutputDebug("hello")
        try {
            OCRResultObj := WaitFindText(this.Regex, Map(
                "Click", false,
                "LoopDelay", LoopDelay,
                "Region", this.Region,
                "ocrOptions", ocrOptions
            ))
            return !!OCRResultObj.FindString(this.Regex, this.searchOptions)
        } catch {
            return false
        }
    }

    ToString() {
        return "Screen(Name: " this.Name ", Regex: " this.Regex ", Region: [" this.Region * "])"
    }
}

/*
global Screens := [
    ;shelter
    Screen("World", "world_Shelter", Regions.icons.world_Shelter, "(?i)Shelter"), ; To detect screen World, shelter need to be present.
    Screen("Shelter", "world_Shelter", Regions.icons.world_Shelter, "(?i)World"), ; To detect screen shelter, World need to be present.
    ;titles
    Screen("Premium Center", "title", Regions.menus.top, "(?i)P.emium Center"),
    Screen("Events", "title", Regions.menus.top, "(?i)Events"),
    Screen("Survivor Profile", "title", Regions.menus.top, "(?i)Survivor P..f..e"),
    Screen("Alliance", "title", Regions.menus.top, "(?i)Alliance\b"),
    Screen("Gifts", "title", Regions.menus.top, "(?i)Gifts\b"),
    Screen("Adventure", "title", Regions.menus.top, "(?i)Adventure"),
    Screen("Daily Tasks", "title", Regions.menus.top, "(?i)Daily Tasks"),
    Screen("Hero List", "title", Regions.menus.top, "(?i)Hero List"),
    Screen("VIP", "title", Regions.menus.top, "(?i)VIP"),
    ; mains
    Screen("Logged", "main", Regions.Events.main, "(?i)Logged"),
    Screen("Applications System", "main", Regions.Events.main, "(?i)Applications syst"),
    Screen("Guy", "main", Regions.Events.main, "(?i)Guy"),
    Screen("Team Details", "main", Regions.Events.main, "(?i)Team Details"),
    Screen("Alliance Techs", "main", Regions.Events.main, "(?i)Alliance Techs"),
    Screen("Create New Character", "main", Regions.Events.main, "(?i)Create New Character"),
    Screen("Create New Character", "main", Regions.Events.main, "(?i)Create New Character"),
    Screen("Support Darkwar Survival", "main", Regions.Events.main, "(?i)Support.*DARkWAR.*SURV.val")
    ;bottom
    Screen("Loading", "bottom", Regions.menus.bottom, "(?i)Support.*DARkWAR.*SURV.val")
]

*/
global Screens := {
    Shelter: {
        World: Screen("World", "world_Shelter", Regions.icons.world_Shelter, "(?i)Shelter"),
        Shelter: Screen("Shelter", "world_Shelter", Regions.icons.world_Shelter, "(?i)World")
    },
    titles: {
        Premium: Screen("Premium Center", "title", Regions.menus.top, "(?i)P.emium Center"),
        Events: Screen("Events", "title", Regions.menus.top, "(?i)Events"),
        Survivor: Screen("Survivor Profile", "title", Regions.menus.top, "(?i)Survivor P..f..e"),
        Alliance: Screen("Alliance", "title", Regions.menus.top, "(?i)Alliance\b"),
        Gifts: Screen("Gifts", "title", Regions.menus.top, "(?i)Gifts\b"),
        Adventure: Screen("Adventure", "title", Regions.menus.top, "(?i)Adventure"),
        Daily: Screen("Daily Tasks", "title", Regions.menus.top, "(?i)Daily Tasks"),
        HeroList: Screen("Hero List", "title", Regions.menus.top, "(?i)Hero List"),
        VIP: Screen("VIP", "title", Regions.menus.top, "(?i)VIP")
    },
    Mains: {
        Logged: Screen("Logged", "main", Regions.Events.main, "(?i)Logged"),
        Applications: Screen("Android", "main", Regions.Events.main, "(?i)Applications syst"),
        Guy: Screen("Guy", "main", Regions.Events.main, "(?i)Guy"),
        Team: Screen("Team Details", "main", Regions.Events.main, "(?i)Team Details"),
        Techs: Screen("Alliance Techs", "main", Regions.Events.main, "(?i)Alliance Techs"),
        Create: Screen("Create New Character", "main", Regions.Events.main, "(?i)Create New Character"),
        Support: Screen("Support Darkwar Survival", "main", Regions.Events.main, "(?i)Support.*DARkWAR.*SURV.val")
    },
    Bottom: {
        Loading: Screen("Loading", "bottom", Regions.menus.bottom, "(?i)Support.*DARkWAR.*SURV.val")
    }
}

GetScreenByName(name) {
    global Screens
    for _, screen in Screens {
        if (screen.Name = name)
            return screen
    }
    return ""
}

GetAllScreens(obj := Screens) {
    all := []
    for k, v in obj {
        if IsObject(v) && v.HasKey("Name") {
            all.Push(v)
        } else if IsObject(v) {
            all.Push(GetAllScreens(v)*)  ; recursively flatten and spread
        }
    }
    return all
}
