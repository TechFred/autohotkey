#Requires AutoHotkey v2.0

TakeScreenshot() {
    LoggerInstance.dekbug("Taking screenshot...")
    ; Take screenshot and save to PNG file
    screenshotPath := A_ScriptDir "\screenshot\screenshot_" A_Now ".png"

    Send("{PrintScreen}")
    Sleep(500)  ; Give time for clipboard to update

    if A_Clipboard.HasFormat("Bitmap") {
        ; Save clipboard image to file
        try {
            ClipSaved := ClipboardAll()  ; Backup clipboard
            img := A_Clipboard
            img.Save(screenshotPath)
            LoggerInstance.info("Screenshot saved to: " screenshotPath)
        } catch {
            LoggerInstance.warn("Failed to save screenshot: " . A_LastError)
        }
    } else {
        LoggerInstance.warn("Failed to save screenshot: no image in Clipboard")
    }

}
