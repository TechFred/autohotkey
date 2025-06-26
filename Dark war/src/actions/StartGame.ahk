#Requires AutoHotkey v2.0

O_winmaximise := ("maximise.bmp", 75, Regions.AppRegion)

StartDarkWar() {

    i := 0
    GameActive := false
    loop {
        if !WinExist(winTitle) {
            LoggerInstance.info("Starting DarkWar")
            ;Run('"C:\Program Files\BlueStacks_nxt\HD-Player.exe" --instance Nougat32 --cmd launchApp --package "com.readygo.dark.gp" --source desktop_shortcut')

            Run(
                '"C:\Program Files\BlueStacks_nxt\HD-Player.exe" --instance Nougat32 --cmd launchApp --package "com.readygo.dark.gp" --source desktop_shortcut'
            )
            Sleep (20000)
            i += 1
            LoggerInstance.debug("Starting DarkWar attempt: " i)
        } else if (WinExist(winTitle)) {
            listAllWindows()
            LoggerInstance.info("Trying to activate Darkwar")
            GameActive := WinActivateGame()
        }

    }
    until (i > 20) || GameActive

    if (i > 20) {
        LoggerInstance.warn("Can't start Darkwar. Exiting")
        QuitGame(1)
    }
    LoggerInstance.info("DarkWar running")

}

WinActivateGame() {

    WindowsisActivated := false
    if (WinExist(winTitle)) {
        LoggerInstance.debug("Trying to activate window")
        ;WinRestore(winTitle)
        WinSetAlwaysOnTop(1, winTitle)
        WinActivate(winTitle)
        WinWaitActive(winTitle, "", 10)

        if WinWaitActive(winTitle, "", 10) {
            LoggerInstance.debug("Window is active")
            WindowsisActivated := true
            ;WinRestore(winTitle)
            Sleep(2000)
            if !ToggleFullScreen() {
                LoggerInstance.debug("warn Fullscreen not toggled")
                QuitGame()
            }

            ;ImageFinderInstance.LoopFindAnyImageObjects(4000, true, 200, 10, O_winmaximise)
            ;MouseClick("left", 352, 15, 2)
            ;MouseMove(100, 15)

        }

    }
    return WindowsisActivated
}

QuitGame(code := 99) {
    BlockInput("MouseMoveOff")
    TakeScreenshot()
    CloseApplication()
    LoggerInstance.Info("Done with code: " code)
    ExitApp(code)
}

listAllWindows() {

    ids := WinGetList()  ; Get all window handles (HWNDs)

    for this_id in ids {
        this_title := WinGetTitle(this_id)  ; Get window title
        this_class := WinGetClass(this_id)  ; Get window class
        LoggerInstance.debug ("Window ID: " this_id " Title: " this_title " Class: " this_class)

    }

}

ToggleFullScreen() {
    r := false
    loop 10 {
        if Screens.Custom.BlueStacks.WaitForMatch(1000) {
            LoggerInstance.info("Toggling Fullscreen")
            Send "{F11}"
            Sleep(4000)
        } else {
            return true
        }
    }
    return false

}

CloseApplication() {
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
