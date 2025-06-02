#Requires AutoHotkey v2.0

;Instances
LoggerInstance := Logger(A_ScriptDir, "DEBUG")
ImageFinderInstance := ImageFinder(A_ScriptDir "\assets\images\")

; Windows
winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
SetTitleMatchMode(2)

; Activate the game window
;if WinExist(winTitle) {
;    WinMaximize(winTitle)
;    WinActivate(winTitle)
;    WinWaitActive(winTitle)
;}

; Input
BlockInput("MouseMove")

; Starting
LoggerInstance.Info("Starting script - " A_ScriptDir)

; users
try
    Users := importuser()
catch as e {
    LoggerInstance.Warn("Crash importing users: " e.Message)
    ExitApp()

}

if debug = false {
    StartDarkWar()
}
;

; ======= Debugging =======
if debug {
    LoggerInstance.Info("Debugging mode enabled")
    sleep (2000)
    BlockInput("MouseMoveOff")
    WinActivate(winTitle)
    WinWaitActive(winTitle)
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
    premiumCenter()
    events()

    O_reddot_number_transblack := Image("reddot_number_transblack.bmp", 60, Regions.events.bottom, TransBlack)
    O_reddot_number_transblack_bottom := O_reddot_number_transblack.Clone()
    O_reddot_number_transblack_bottom.region := Regions.events.bottom

    res := ImageFinderInstance.FindAnyImageObjects(1000, false, O_reddot_number_transblack_bottom)
    MouseMove(res.x, res.y)
    MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y

    ExitApp()
}

; Special
Sleep(2000)
Hospital()

if getCurrentScreen() = SCREEN_WORLD {
    boomers()
    ExitApp
}

;Login and start

for u in Users {
    LoggerInstance.info("Starting User: " u.name)
    done := false

    loop {

        try {
            loop {
                LoggerInstance.Debug("Starting logging loop")
                LoggerInstance.info("Waiting for loading...")
                LoadingWait()
                LoggerInstance.info("Waiting for Splash...")
                splash()
                CrashDetection()
                LoggerInstance.info("Logging in as: " u.name)
            } until LoginAndSetUser(u)

            Complete_run(u)
            done := true
        } catch as e {
            LoggerInstance.Warn("Crash detected for user " u.name ": " e.Message)
        }
    } until done
}

Complete_run(u) {

    ; Food
    LoggerInstance.info("Food")
    CrashDetection()
    iconHelpClick()
    food()
    optimise()

    ;Levelup
    LoggerInstance.info("Level up")
    CrashDetection()
    iconHelpClick()
    levelup()

    ; Escorts
    LoggerInstance.info("Escorts")
    CrashDetection()
    iconHelpClick()
    escorts()

    ;Combat
    LoggerInstance.info("Combat")
    CrashDetection()
    iconHelpClick()
    combat()

    ;Alliance
    LoggerInstance.info("Alliance")
    CrashDetection()
    iconHelpClick()
    alliance()

    ;Tasks
    LoggerInstance.info("Tasks")

    CrashDetection()
    iconHelpClick()
    Task()

    ;BattleRewards
    LoggerInstance.info("Battle Rewards")
    CrashDetection()
    iconHelpClick()
    BattleRewards()

    ;Expeditions
    LoggerInstance.info("Expeditions")
    CrashDetection()
    iconHelpClick()
    expeditions()

    ;Energy
    if (u.energy_run) {
        LoggerInstance.info("Energy")
        CrashDetection()
        iconHelpClick()
        energy()
    }

    ;boomers
    if (u.boomer_run) {
        LoggerInstance.info("Boomers")
        CrashDetection()
        iconHelpClick()
        boomers()
        if (u.energy_run) {
            LoggerInstance.info("Energy and boomers (2)")
            CrashDetection()
            iconHelpClick()
            energy()
            boomers()
        }
    }

    ;events
    LoggerInstance.info("Events")
    CrashDetection()
    iconHelpClick()
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

BlockInput("MouseMoveOff")
LoggerInstance.Info("Done")
;msgbox ("done")
ExitApp()

; ===== HOTKEY: ESC to exit =====
Esc:: {
    BlockInput("MouseMoveOff")
    BlockInput("Off")
    ExitApp()
}
