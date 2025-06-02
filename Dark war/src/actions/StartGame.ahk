#Requires AutoHotkey v2.0

O_winmaximise := ("maximise.bmp", 75, Regions.AppRegion)

StartDarkWar() {

    i := 0
    loop {
        if !WinExist(winTitle) {
            LoggerInstance.info("Starting DarkWar")
            ;Run('"C:\Program Files\BlueStacks_nxt\HD-Player.exe" --instance Nougat32 --cmd launchApp --package "com.readygo.dark.gp" --source desktop_shortcut')

            Run(
                '"C:\Program Files\BlueStacks_nxt\HD-Player.exe" --instance Nougat32 --cmd launchApp --package "com.readygo.dark.gp" --source desktop_shortcut'
            )
            sleep (20000)
            i += 1
            LoggerInstance.debug("Starting DarkWar " i)
        } else if (WinExist(winTitle)) {

            WinActivateGame()

            LoggerInstance.info("DarkWar running")
            break
        }

    }
    until (i > 20)

    if (i > 20) {
        LoggerInstance.warn("Can't start Darkwar. Exiting")
        ExitApp()
    }

}

WinActivateGame() {
    if (WinExist(winTitle)) {

        WinActivate(winTitle)
        WinWaitActive(winTitle)
        Sleep(1000)
        WinRestore(winTitle)
        Sleep(2000)
        ;ImageFinderInstance.LoopFindAnyImageObjects(4000, true, 200, 10, O_winmaximise)
        ;MouseMove(352, 15)
        MouseMove(260, 15)
        Sleep(200)
        Click("left", 2)
        WinSetAlwaysOnTop(1, winTitle)
    }
}
