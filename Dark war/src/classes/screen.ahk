#Requires AutoHotkey v2.0

class Screen {
    Region := [0, 0, 0, 0]
    Name := ""
    Regex := ""
    searchOptions := MapToObject(Map("IgnoreLinebreaks", true, "SearchFunc", RegExMatch))
    ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0)

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
    WaitForMatch(LoopDelay := 8000, ocrOptions := this.ocrOptions) {
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

class Screens {
    static Shelter := {
        World: Screen("World", "world_Shelter", Regions.icons.world_Shelter, "(?i)Shelter"),  ; If Shelter is detected -> World
        Shelter: Screen("Shelter", "world_Shelter", Regions.icons.world_Shelter, "(?i)..rld")  ; If World is detected -> Shelter
        ; Note Word string is best with "casesense", 0, "grayscale", 0, "lang", en-us, "mode", 4, "scale", 3
    }

    static Titles := {
        Premium: Screen("Premium Center", "title", Regions.menus.top, "(?i)P.emium Center"),
        Events: Screen("Events", "title", Regions.menus.top, "(?i)Events"),
        Survivor: Screen("Survivor Profile", "title", Regions.menus.top, "(?i)Survivor P..f..e"),
        Alliance: Screen("Alliance", "title", Regions.menus.top, "(?i)Alliance\b"),
        Gifts: Screen("Gifts", "title", Regions.menus.top, "(?i)Gifts\b"),
        Adventure: Screen("Adventure", "title", Regions.menus.top, "(?i)Adventure"),
        HeroList: Screen("Hero List", "title", Regions.menus.top, "(?i)Her[o0] List"),
        VIP: Screen("VIP", "title", Regions.menus.top, "(?i)VIP"),
        SeasonMgt: Screen("Season Management", "title", Regions.menus.top, "(?i)Seaso. M.{1,3}ageMe.{1,3}t"),
    }

    static Mains := {
        Logged: Screen("Logged", "main", Regions.Events.main, "(?i)Logged"),
        Android: Screen("Android", "main", Regions.Events.main, "(?i)JEUX POPULAIRE|POPULAR GAMES TO PLAY"),
        Guy: Screen("Guy", "main", Regions.Events.main, "(?i)Guy"),
        Team: Screen("Team Details", "main", Regions.Events.main, "(?i)Team Details"),
        Techs: Screen("Alliance Techs", "main", Regions.Events.main, "(?i)Alliance Techs"),
        Create: Screen("Create New Character", "main", Regions.Events.main, "(?i)Create New Character"),
        Loading: Screen("Android", "main", Regions.Events.main, "(?i)Support.*DARkWAR.*SURV.val"),
        Daily: Screen("Daily Tasks", "main", Regions.Events.main, "(?i)Daily Tasks"),
        Logout: Screen("Logout", "main", Regions.Events.main, "(?i)logged in on another"),
        Healing: Screen("Healing", "main", Regions.Events.main, "(?i)Heal Wounded Units")
    }

    static Bottom := {
        Loading: Screen("Loading", "bottom", Regions.menus.bottom, "(?i)Support.*DARkWAR.*SURV.val")
    }
    static Custom := {
        BlueStacks: Screen("BlueStacks - Not Full Screen", "custom", Regions.AppRegion, "(?i)BlueStacks App Player")
    }

}

GetAllScreensFlat() {
    all := []
    for _, section in Screens.OwnProps() {
        for _, screen in section.OwnProps() {
            if IsObject(screen) && screen.HasOwnProp("Name") {
                all.Push(screen)
            }
        }
    }
    return all
}

GetScreenByName(name) {
    for _, screen in Screens {
        if (screen.Name = name)
            return screen
    }
    return ""
}

;Fix
Screens.Shelter.Shelter.ocrOptions := Map("casesense", 0, "grayscale", 1, "lang", "en-us", "mode", 4, "scale", 3)