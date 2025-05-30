#Requires AutoHotkey v2.0



;Instances
LoggerInstance := Logger(A_ScriptDir "\run.log", "DEBUG")
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

debug := false
;debug := true

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

    Events_new_btn := Image("Events_new_bnt.bmp", 50, Regions.AllRegion)
    res := ImageFinderInstance.FindAnyImageObjects(1000, false, Events_new_btn)
    MouseMove(res.x, res.y)
    MsgBox "Found: " res.Found "`nx: " res.x "`ny: " res.y

    ExitApp()
}

; Special
if getCurrentScreen() = SCREEN_WORLD {
    boomers()
    ExitApp
}

;Login and start

for u in Users {
    LoggerInstance.info("Starting User:" u.name)
    done := false

    loop {

        try {
            loop {
                LoggerInstance.Debug("Starting logging loop")
                LoadingWait()
                splash()
                CrashDetection()

            } until LoginAndSetUser(u)

            Complete_run(u)
            done := true
        } catch as e {
            LoggerInstance.Warn("Crash detected for user " u.Name ": " e.Message)
        }
    } until done
}

Complete_run(u) {

    ; Food
    CrashDetection()
    iconHelpClick()
    food()
    optimise()

    ;Levelup
    CrashDetection()
    iconHelpClick()
    levelup()

    ; Escorts
    CrashDetection()
    iconHelpClick()
    escorts()

    ;Combat
    CrashDetection()
    iconHelpClick()
    combat()

    ;Alliance
    CrashDetection()
    iconHelpClick()
    alliance()

    ;Tasks
    CrashDetection()
    iconHelpClick()
    Task()

    ;BattleRewards
    CrashDetection()
    iconHelpClick()
    BattleRewards()

    ;Expeditions
    CrashDetection()
    iconHelpClick()
    expeditions()

    ;Energy
    if (u.energy_run) {
        CrashDetection()
        iconHelpClick()
        energy()
    }

    ;boomers
    if (u.boomer_run) {
        CrashDetection()
        iconHelpClick()
        boomers()
        if (u.energy_run) {
            CrashDetection()
            iconHelpClick()
            energy()
            boomers()
        }
    }

    ;events
    CrashDetection()
    iconHelpClick()
    events()

    ;premiumCenter
    CrashDetection()
    iconHelpClick()
    premiumCenter()

    ;End script
    CrashDetection()
    iconHelpClick()
}

BlockInput("MouseMoveOff")
msgbox ("done")
ExitApp()

; ===== HOTKEY: ESC to exit =====
Esc:: {
    BlockInput("MouseMoveOff")
    BlockInput("Off")
    ExitApp()
}
