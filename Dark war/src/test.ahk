#Requires AutoHotkey v2.0


O_winmaximise := ("maximise.bmp", 20, Regions.AllRegion)
; Windows
winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
SetTitleMatchMode(2)

if (WinExist(winTitle)) {

    WinActivate(winTitle)
    WinWaitActive(winTitle)
    Sleep(1000)
    WinMove(0, 0, 1920, 1080, WinTitle)
    Sleep(4000)
    WinMaximize(winTitle)
    Sleep(1000)
    WinMinimize(winTitle)
    WinRedraw (winTitle)
    Sleep(1000)
    WinMaximize(winTitle)
    
    ;WinSetAlwaysOnTop(1, winTitle)
}
