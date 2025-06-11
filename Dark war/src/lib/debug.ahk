#Requires AutoHotkey v2.0

HighlightRegion(region, duration := 5000) {
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

    if debug = true || GetOCRRegion = true {
        LoggerInstance.Info("Debugging mode enabled")
        Sleep (2000)
        BlockInput("MouseMoveOff")
        WinActivate(winTitle)
        WinWaitActive(winTitle)

        if GetOCRRegion {
            debugOCRRegion()
        }

        ; ===============================
        if debug {
            DebugClaim()
            Debugclose()
            
        }

        BlockInput("MouseMoveOff")
        BlockInput("Off")
        WinSetAlwaysOnTop(0, winTitle)
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
    iconEventsClick()
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
    /*
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
    */

    ; O_reddot_number_transblack := Image("reddot_number_transblack.bmp", 60, Regions.events.bottom, TransBlack)
    ; O_reddot_number_transblack_bottom := O_reddot_number_transblack.Clone()
    ; O_reddot_number_transblack_bottom.region := Regions.events.bottom

    ; res := ImageFinderInstance.FindAnyImageObjects(1000, false, O_reddot_number_transblack_bottom)
    ; MouseMove(res.x, res.y)
    ; MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y

}

debugOCRRegion() {
    LoggerInstance.debug("++++ OCR Region ++++")


    ; OCR.DisplayImage := true
    ocrOptions := Map("lang", "en-us", "scale", 3, "grayscale", 0, "casesense", 0, "mode", 4)

    LoggerInstance.Debug("==== Event Main ====")
    debugGetTextRegion(Regions.Events.main, ocrOptions)
    LoggerInstance.Debug("==== menus top ====")
    debugGetTextRegion(Regions.menus.top, ocrOptions)
    LoggerInstance.Debug("==== menus Bottom ====")
    debugGetTextRegion(Regions.menus.bottom, ocrOptions)
    LoggerInstance.Debug("==== All ====")
    debugGetTextRegion(Regions.AllRegion, ocrOptions)

    /*
    LoggerInstance.debug("++++ OCR Region mode 5 ++++")
    ; OCR.DisplayImage := true
    ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 0, "casesense", 0, "mode", 5)

    LoggerInstance.Debug("==== Event Main ====")
    debugGetTextRegion(Regions.Events.main, ocrOptions)
    LoggerInstance.Debug("==== menus top ====")
    debugGetTextRegion(Regions.menus.top, ocrOptions)
    LoggerInstance.Debug("==== menus Bottom ====")
    debugGetTextRegion(Regions.menus.bottom, ocrOptions)
    LoggerInstance.Debug("==== All ====")
    debugGetTextRegion(Regions.AllRegion, ocrOptions)

    LoggerInstance.debug("++++ OCR Region mode 4 monochrome ++++")
    ; OCR.DisplayImage := true
    ocrOptions := Map("lang", "en-us", "scale", 3, "grayscale", 1, "casesense", 0, "mode", 4, "monochrome", 128)

    LoggerInstance.Debug("==== Event Main ====")
    debugGetTextRegion(Regions.Events.main, ocrOptions)
    LoggerInstance.Debug("==== menus top ====")
    debugGetTextRegion(Regions.menus.top, ocrOptions)
    LoggerInstance.Debug("==== menus Bottom ====")
    debugGetTextRegion(Regions.menus.bottom, ocrOptions)
    LoggerInstance.Debug("==== All ====")
    debugGetTextRegion(Regions.AllRegion, ocrOptions)

    LoggerInstance.debug("++++ OCR Region mode 5 monochrome ++++")
    ; OCR.DisplayImage := true
    ocrOptions := Map("lang", "en-us", "scale", 1, "grayscale", 0, "casesense", 0, "mode", 5, "monochrome", 128)

    LoggerInstance.Debug("==== Event Main ====")
    debugGetTextRegion(Regions.Events.main, ocrOptions)
    LoggerInstance.Debug("==== menus top ====")
    debugGetTextRegion(Regions.menus.top, ocrOptions)
    LoggerInstance.Debug("==== menus Bottom ====")
    debugGetTextRegion(Regions.menus.bottom, ocrOptions)
    LoggerInstance.Debug("==== All ====")
    debugGetTextRegion(Regions.AllRegion, ocrOptions)

    Region1 := [1191, 336, 1357, 852]
    LoggerInstance.Debug("==== Custom1 ====")
    debugGetTextRegion(Region1)
    Region1 := [807, 795, 1407, 946]
    LoggerInstance.Debug("==== Custom2 ====")
    debugGetTextRegion(Region1)
    */
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
    Sleep(500)
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

DebugClaim(){
    ClaimloopOCR()
}