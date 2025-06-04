#Requires AutoHotkey v2.0

class Screen {
    Region := [0, 0, 0, 0]
    Name := ""
    Regex := ""
    searchOptions := Map("IgnoreLinebreaks", true, "SearchFunc", RegExMatch)

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

    FindScreen(ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0)) {

        try {
            OCRResultObj := WaitFindText(this.Regex, Map(
                "Click", false,
                "LoopDelay", 8000,
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

global Screens := [
    ;shelter
    Screen("World", "world_Shelter", Regions.icons.world_Shelter, "(?i)World"),
    Screen("Shelter", "world_Shelter", Regions.icons.world_Shelter, "(?i)Shelter"),
    ;tops
    Screen("Premium Center", "top", Regions.menus.top, "(?i)P.emium Center"),
    Screen("Events", "top", Regions.menus.top, "(?i)Events"),
    Screen("Survivor Profile", "top", Regions.menus.top, "(?i)Survivor P.ofile"),
    Screen("Alliance", "top", Regions.menus.top, "(?i)Alliance\b"),
    Screen("Gifts", "top", Regions.menus.top, "(?i)Gifts\b"),
    Screen("Adventure", "top", Regions.menus.top, "(?i)Adventure"),
    Screen("Daily Tasks", "top", Regions.menus.top, "(?i)Daily Tasks"),
    Screen("Hero List", "top", Regions.menus.top, "(?i)Hero List"),
    Screen("VIP", "top", Regions.menus.top, "(?i)VIP"),
    ; mains
    Screen("Logged", "main", Regions.Events.main, "(?i)Logged"),
    Screen("Applications System", "main", Regions.Events.main, "(?i)Applications syst"),
    Screen("Guy", "main", Regions.Events.main, "(?i)Guy"),
    Screen("Team Details", "main", Regions.Events.main, "(?i)Team Details"),
    Screen("Alliance Techs", "main", Regions.Events.main, "(?i)Alliance Techs")
]