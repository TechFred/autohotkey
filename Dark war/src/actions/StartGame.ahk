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
            LoggerInstance.debug("Starting DarkWar " i)
        } else if (WinExist(winTitle)) {
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
        WinActivate(winTitle)
        WinWaitActive(winTitle, "", 10000)
        WinActivate(winTitle)

        if WinWaitActive(winTitle, "", 10000) {
            LoggerInstance.debug("Window is active")
            WindowsisActivated := true
            Sleep(1000)
            WinRestore(winTitle)
            Sleep(2000)
            ;ImageFinderInstance.LoopFindAnyImageObjects(4000, true, 200, 10, O_winmaximise)
            MouseClick("left", 352, 15, 2)
            ;MouseMove(100, 15)
            WinSetAlwaysOnTop(1, winTitle)
        }

    }
    return WindowsisActivated
}

QuitGame(code := 99) {
    BlockInput("MouseMoveOff")
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
    LoggerInstance.Info("Done with code: " code)
    ExitApp(code)
}
