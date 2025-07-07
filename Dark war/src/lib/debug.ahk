#Requires AutoHotkey v2.0

HighlightRegion(region, duration := 10000) {
    ; Create GUI with no border and transparent background
    guiobj := Gui("+AlwaysOnTop -Caption +ToolWindow +LastFound")
    guiobj.BackColor := "Red"

    ; Calculate width and height
    w := region[3] - region[1]
    h := region[4] - region[2]

    ; Set the position and size
    guiobj.Show("x" region[1] " y" region[2] " w" w " h" h)

    ; Make the GUI semi-transparent (optional)
    WinSetTransparent(150, "ahk_id " guiobj.Hwnd)

    ; Wait, then destroy
    ;Sleep(duration)
    SetTimer (*) => guiobj.Destroy(), -duration

}

HighlightRegionInWindow(region, duration := 5000) {
    try {
        ; Get window position
        WinGetPos(&wx, &wy, , , winTitle)

        ; Offset region coordinates relative to the window
        x := wx + region[1]
        y := wy + region[2]
        w := region[3] - region[1]
        h := region[4] - region[2]

        ; Create transparent GUI for highlight
        guiobj := Gui("+AlwaysOnTop -Caption +ToolWindow +LastFound")
        guiobj.BackColor := "Red"
        guiobj.Show("x" x " y" y " w" w " h" h)
        WinSetTransparent(150, "ahk_id " guiobj.Hwnd)

        ; Auto destroy after duration
        ;Sleep(duration)
        SetTimer (*) => guiobj.Destroy(), -duration
    } catch as e {
        MsgBox "Error highlighting region: " e.Message
        MsgBox "Error highlighting region: " e.stack
    }
}

debugGetTextRegion(region := Regions.AllRegion, ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0)) {

    ocrOptionsRegion(ocrOptions, region)
    T := OCR.FromWindow(winTitle, MapToObject(ocrOptions))
    LoggerInstance.Debug(T.Text)
}

CheckDebug() {

    if debug = true || GetOCRRegion = true || debugimage = true {
        LoggerInstance.Info("Debugging mode enabled")
        Sleep (2000)
        BlockInput("MouseMoveOff")
        WinActivate(winTitle)
        WinWaitActive(winTitle)

        if GetOCRRegion {
            debugOCRRegion()
        }

        if debugimage {
            ;DebugimageObject(rednumber2)
            ;Sleep(11000)
            ;HighlightAllImages(redtest)
            founds := ImageSearchAll(O_reddot_transblack)

            for img in founds {
                Region := [img.x, img.y, img.x + 20, img.y + 20]
                HighlightRegionInWindow(Region)
            }
            LoggerInstance.debug("Done")
            Sleep(10000)

        }
        ; ===============================
        if debug {
            Season2()
            ;ClaimLoopOCR(5000, 5, Regions.events.main)

            ;vip()

            /*
            
                        HighlightRegionInWindow(Regions.events.main, 5000)
                        HighlightRegionInWindow(Regions.events.bottom, 5000)
                        sleep (5000)
            
            */

        }
        BlockInput("MouseMoveOff")
        BlockInput("Off")
        WinSetAlwaysOnTop(0, winTitle)
        LoggerInstance.Debug("Debug done")
        Sleep(10000)
        ExitApp()
    }

}

DebugNormal() {
    FindPixelColorRegion(Sleep := 2000, DoClick := true, targetColor := 0xF3AC41, region := Regions.Events.main)
    /*
    HighlightRegionInWindow(Regions.menus.top)
    LoggerInstance.debug(Screens.mains.Daily.WaitForMatch())
    Sleep(5000)
    HighlightRegionInWindow(Regions.Events.main)
    Sleep(5000)
    */
    LoginAndSetUser(Users[1])

    ;events
    CrashDetection()
    iconeventsClick()
    events()

    ;premiumCenter
    LoggerInstance.info("Premium Center")
    CrashDetection()
    iconHelpClick()
    premiumCenter()

    ;End script
    LoggerInstance.info("Ending script")
    CrashDetection()
    iconHelpClick()

}

debugOCRRegion() {

    list_oocrOption := [
        ;Map("lang", "en-us", "scale", 4, "grayscale", 0, "casesense", 0,),
        Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0, "mode", 4,),
        Map("lang", "en-us", "scale", 1, "grayscale", 0, "casesense", 0, "mode", 4,),
        Map("lang", "en-us", "scale", 3, "grayscale", 1, "casesense", 0, "mode", 4,),
        Map("lang", "en-us", "scale", 3, "grayscale", 0, "casesense", 0, "mode", 4,),
        Map("lang", "en-us", "scale", 5, "grayscale", 1, "casesense", 0, "mode", 4,),
        Map("lang", "en-us", "scale", 5, "grayscale", 0, "casesense", 0, "mode", 4,),
        ;Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 5, "invertcolors", 1, "monochrome", 200),
        ;Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 5, "invertcolors", 0, "monochrome", 0),
        ;Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 5, "invertcolors", 1, "monochrome", 0),
        Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 1, "invertcolors", 1, "monochrome", 220),
        Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 3, "invertcolors", 1, "monochrome", 220),  ;texte blanc
        Map("casesense", 0, "grayscale", 0, "lang", "en-us", "mode", 4, "scale", 6, "invertcolors", 1, "monochrome", 220)  ;texte blanc

    ]

    ;"Region", Regions.events.main,"lang", "en-us", "scale", 3, "grayscale", 0, "casesense", 0

    i := 0
    for opt in list_oocrOption {
        LoggerInstance.debug("`n`n++++ OCR Region " i " ++++")
        debugOCRRegionOptions(opt)
        i += 1
    }

    OCR.DisplayImage := true
    OCR.DisplayImage := false

}

debugOCRRegionOptions(ocrOptions) {
    ;OCR.DisplayImage := true
    LoggerInstance.debug("`n`n++++ OCR Region ++++")
    LoggerInstance.debug(MapToLogString(ocrOptions))

    LoggerInstance.Debug("==== Event Main ====")
    debugGetTextRegion(Regions.Events.main, ocrOptions)

    LoggerInstance.Debug("==== menus top ====")
    ;debugGetTextRegion(Regions.menus.top, ocrOptions)

    LoggerInstance.Debug("==== menus Bottom ====")
    ;debugGetTextRegion(Regions.menus.bottom, ocrOptions)

    LoggerInstance.Debug("==== All ====")
    ;debugGetTextRegion(Regions.AllRegion, ocrOptions)

    OCR.DisplayImage := false

    /*
    OCR.DisplayImage := true
    LoggerInstance.Debug("==== Special ====")
    debugGetTextRegion(Regions.icons.Season2, ocrOptions)
    OCR.DisplayImage := false
    */
    ;LoggerInstance.Debug("==== World ====")
    ;debugGetTextRegion(Regions.icons.world_Shelter, ocrOptions)

}

DebugOCRclick() {
    ;    username := RegExReplace("UnknownWildling", "[ilo]", ".") ; replace difficut OCR chars.
    ; username := RegExReplace("LeBalafré", "[ilo]", ".")
    username := RegExReplace("UnknownWildling", "[ilo]", ".")

    username := "(?i)\[.{1,6}\]" username  ; Contains [...]Username
    WaitFindText(username, Map(
        "Click", true,
        "ClickDelay", 1000,
        "LoopDelay", 5000,
        "Region", Regions.events.main
    ))

}

Debugclose() {
    TakeScreenshot()

    if WinExist(winTitle) {
        ; Close the window gracefully
        WinClose(winTitle)
        LoggerInstance.Info("Close HD-Player.exe")

        ; If the process doesn't close, force it
        Sleep(5000)
        if WinExist(winTitle) {
            ProcessClose("HD-Player.exe")
            LoggerInstance.warn("Force closed HD-Player.exe")
        }
    }

}

DebugClaim() {
    ClaimLoopOCR()
}

DebugimageObject(O) {

    if res := ImageFinderInstance.FindAnyImageObjects(1000, false, O) {
        MouseMove(res.x, res.y)
        LoggerInstance.debug("Found: " res.Found " x: " res.x " y: " res.y)

        R := [res.x, res.y, res.x + 20, res.y + 20]
        HighlightRegionInWindow(R)
        Sleep(3000)
    } else {
        LoggerInstance.debug("Not found: " O.name)
    }

}

MapToLogString(map) {
    result := "`n"
    for key, value in map {
        result .= key ": " value "`n"
        result2 .= Format('"{}", {}, ', key, IsObject(value) ? '"' value '"' : value)
    }
    result2 := SubStr(result2, 1, -2)  ; remove the last comma and space
    OutputDebug(result2)

    return result
}

debugaction() {

    SeasonMgt()
}

debugaction2() {
    TakeScreenshot()
}

HighlightAllImages(img) {

    path := (ImageFinderInstance.assetsPath img.path)
    tolerance := img.tolerance
    transcolor := img.transcolor
    Region := img.region
    ; Get screen dimensions
    screenWidth := Region[3]
    screenHeight := Region[4]

    ; Start coordinates
    x := Region[1]
    y := Region[2]

    ; Loop to find all occurrences
    while true {
        LoggerInstance.debug("searching")
        found := ImageSearch(&FoundX, &FoundY, x, y, screenWidth, screenHeight, transcolor " *" tolerance " " path)

        if !found {
            LoggerInstance.debug("not found")
            break
        }
        LoggerInstance.debug("Found: " found " x: " FoundX " y: " FoundY)

        ; Get image dimensions
        imgW := 20
        imgH := 20

        ; Highlight found region
        Region := [FoundX, FoundY, FoundX + imgW, FoundY + imgH]
        HighlightRegionInWindow(Region)

        ; Move search origin past the found image
        x := FoundX + imgW
        if x >= screenWidth {
            x := 0
            y := FoundY + imgH
            if y >= screenHeight {
                break
            }
        }
    }
}

ImageSearchAll(img, x1 := 0, y1 := 0, x2 := 'Screen', y2 := 'Screen') {

    path := (ImageFinderInstance.assetsPath img.path)
    tolerance := img.tolerance
    transcolor := img.transcolor
    Region := img.region

    x2 := x2 = 'Screen' ? A_ScreenWidth : x2
    y2 := y2 = 'Screen' ? A_ScreenHeight : y2
    found := []
    y := y1
    loop {
        x := x1
        lastFoundY := 0
        while f := ImageSearch(&foundX, &foundY, x, y, x2, y2, transcolor " *" tolerance " " path) {
            if (lastFoundY = 0 || lastFoundY = foundY) {
                found.Push({ x: foundX, y: foundY })
                LoggerInstance.debug("Found: " f " x: " foundX " y: " foundY)
                x := foundX + 20
                lastFoundY := foundY
            } else
                break
        }
        y := lastFoundY + 20
    } until (x = x1) && !f
    return found
}

/* Backups

 ;res := ImageFinderInstance.LoopFindImage(shelterIcon, Regions.icons.world_Shelter, 50, 1000, false, 50, 5)
    ;MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y
    ;iconOptimiseClick()
    ;clickAnyBack()
    ;ClickTransblackX()
    ;res := ImageFinderInstance.LoopFindImage(worldIcon, Regions.icons.world_Shelter, 50, 5000, false, 50, 5)
    ;msgbox getCurrentScreen()
    ;res := ImageFinderInstance.LoopFindAnyImageObjects(1000,false, 1000, 5, O_TransblackX)
    ;MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y

    ;res := ImageFinderInstance.LoopFindAnyImageObjects(1000,false, 1000, 5, O_exitGuy)
    ;energy()ImageFinderInstance.FindAnyImageObjects(2000, true, O_reddot_number_transblack)
    ;events()
    ;res := ImageFinderInstance.FindAnyImageObjects(1000, false, O_reddot_number_transblack)
    ;MouseMove(res.x, res.y)

    ;res := GetReddot()
    ;centerShelter()
    ;levelup()
    ;ClickReddot(1000, Regions.events.main)
    ;ClickReddot(1000, Regions.events.main)
    ;ExitApp
    ;premiumCenter()
    ;events()
    ;testwait()
    ;i:= GetReddot()
    ;MouseMove(i.x, i.y)
    getCurrentScreen()
    OutputDebug("hello")
    s := Screen("Guy", "main", Regions.Events.main, "(?i)Guy")
    ;r := s.Find()
    ; AllianceGifts()
    ;ocrOptions := {lang:"en-us", scale:2, grayscale:1, casesense:0}
    ;DebugOCR(ocrOptions, "Claim")
    ;ClaimAllOCR(,Regions.menus.bottom)
    ;ClaimLoopOCR()
    ;RemoveCongratOCR()
    ExitApp()
    WaitFindText("Dark War")
    ocrOptions := Map("scale", 5, "x", 0, "y", 0, "w", 500, "h", 500)

    result := OCR.FromWindow(winTitle, ocrOptions)

    LoggerInstance.Debug(result.Text)

    ;CoordMode "Mouse", "Screen"

    LoggerInstance.Debug("search")
    loop {
        search := " Survivor Profile "
        Sleep 500 ; Small delay to wait for the InputBox to close
        result := OCR.FromWindow(winTitle, { scale: 5 })
        LoggerInstance.Debug(Result.Text)

        found := result.FindString(search, { IgnoreLinebreaks: True })

        LoggerInstance.Debug(found.x "," found.y)
        found.Highlight()
        ; found := result.FindStrings(search, {IgnoreLinebreaks: false})

        break
    }


    ; O_reddot_number_transblack := Image("reddot_number_transblack.bmp", 60, Regions.events.bottom, TransBlack)
    ; O_reddot_number_transblack_bottom := O_reddot_number_transblack.Clone()
    ; O_reddot_number_transblack_bottom.region := Regions.events.bottom

    ; res := ImageFinderInstance.FindAnyImageObjects(1000, false, O_reddot_number_transblack_bottom)
    ; MouseMove(res.x, res.y)
    ; MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y

*/
