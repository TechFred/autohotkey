#Requires AutoHotkey v2.0

/*
WaitFindText("RetryText", Map("Click", true, "ClickDelay", 2000, "LoopDelay", 8000, "Region", Regions.AllRegion, "ocrOptions", Map("scale", 5)))
WaitFindText("RetryText", Map(
    "Click", true,
    "ClickDelay", 2000,
    "LoopDelay", 8000,
    "Region", Regions.AllRegion,
    "ocrOptions", Map("scale", 5)
))
*/

WaitFindText(needle := "", Options := Map()) {
    /*
    Parameters (via Options map):
        needle         : The text to find.
        Options.Click  : True to click when found (default: false)
        Options.ClickDelay : Delay after click in ms (default: 1000)
        Options.LoopDelay  : How long to wait before timeout (default: 5000)
        Options.ocrOptions : OCR options like scale, x, y, w, h (default: {scale: 5})
        Options.searchOptions : FindString options (default: {IgnoreLinebreaks: true})
    */

    ; Set defaults
    Region := Options.Has("Region") ? Options["Region"] : Regions.AllRegion
    doClick := Options.Has("Click") ? Options["Click"] : false
    ClickDelay := Options.Has("ClickDelay") ? Options["ClickDelay"] : 1000
    LoopDelay := Options.Has("LoopDelay") ? Options["LoopDelay"] : 5000
    ocrOptions := Options.Has("ocrOptions") ? Options["ocrOptions"] : Map("lang", "en-us", "scale", 1, "grayscale", 1, "casesense", 0)
    searchOptions := Options.Has("searchOptions") ? Options["searchOptions"] : Map("IgnoreLinebreaks", true, "SearchFunc", RegExMatch)

    if Region {
        ocrOptions["x"] := Region[1]
        ocrOptions["y"] := Region[2]
        ocrOptions["w"] := Region[3] - Region[1]
        ocrOptions["h"] := Region[4] - Region[2]
    }

    searchOptions := MapToObject(searchOptions)
    ocrOptions := MapToObject(ocrOptions)

    ;LoggerInstance.Debug(found.text)

    LoggerInstance.debug(winTitle)
    ;LoggerInstance.debug(ocrOptions.x)
    try {
        ; OCR polling until text is found or timeout
        match := OCR.WaitText(needle, LoopDelay, OCR.FromWindow.Bind(OCR, winTitle, ocrOptions), , RegExMatch)
        ;match := OCR.WaitText(needle, LoopDelay, OCR.FromWindow.Bind(OCR, winTitle, ocrOptions), casesense := False, RegExMatch)

        if match {
            LoggerInstance.debug("Text found " needle)
            ; Optional click
            if doClick {
                LoggerInstance.debug("Clicking " needle)
                match.FindString(needle, searchOptions).Click()
                Sleep(ClickDelay)
            }

            return match
        } else {
            LoggerInstance.debug(" -- ")
            LoggerInstance.debug("Text +NOT+ found " needle)
            getCurrentScreenOCR()
            result := OCR.FromWindow(winTitle, ocrOptions)
            LoggerInstance.Debug(Result.Text)
            LoggerInstance.debug(" -- ")

            if debug = true {
                result := OCR.FromWindow(winTitle, ocrOptions)
                LoggerInstance.Debug(Result.Text)
                DebugOCR(ocrOptions, needle, searchOptions)
            }
            return false
        }

    } catch as e {
        OutputDebug(e.message)
        OutputDebug(e.stack)
        return false
    }
}

testwait() {
    ocrOptions := Map("scale", 3, "x", 100, "y", 200, "w", 800, "h", 400)

    ; Wait for text "Yourself" to appear, case-insensitive search, indefinite wait. Search only the active window.
    result := OCR.WaitText("Continue", , OCR.FromWindow.Bind(OCR, "A", ocrOptions))
    ; Find the Word for "Yourself" in the result, and click it.
    result.FindString("Continue").Click()
}

DebugOCR(ocrOptions, needle, searchOptions) {

    ;needle := "Claim "

    /*
    ocrOptions := Map("scale", 5,"grayscale", 1 )
    ocrOptions := { lang: "en-us", scale: 2, grayscale: 1 }
    */
    OCR.DisplayImage := true

    LoggerInstance.debug("debug - finding " needle)
    try {
        result := OCR.FromWindow(winTitle, ocrOptions)
        sleep (1000)
        ;WinClose("ahk_class AutoHotkeyGUI")
        WinActivate(winTitle)

        found := result.FindString(needle, searchOptions)
        LoggerInstance.Debug(found.x "," found.y)
        found.Highlight()
        MouseMove(found.x, found.y)
    } catch as e {

    } finally {
        OCR.DisplayImage := false
        LoggerInstance.Debug(Result.Text)

    }

    ;result := OCR.FromWindow(winTitle, { lang: "en-us", scale: 2, grayscale: 1 })

}

MapToObject(map) {
    obj := {}
    for k, v in map
        obj.%k% := v
    return obj
}

ocrOptionsRegion(ocrOptions, Region) {
    if Region {
        ocrOptions["x"] := Region[1]
        ocrOptions["y"] := Region[2]
        ocrOptions["w"] := Region[3] - Region[1]
        ocrOptions["h"] := Region[4] - Region[2]
    }
    return ocrOptions
}
