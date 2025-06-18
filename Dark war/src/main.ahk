#Requires AutoHotkey v2.0

;Instances
LoggerInstance := Logger(A_ScriptDir, "DEBUG")
ImageFinderInstance := ImageFinder(A_ScriptDir "\assets\images\")

; import file
; Get first CLI parameter if provided
;configPath := A_Args.Length ? A_Args[1] : "config.json"
if (A_Args.Length > 0) {
    configPath := A_Args[1]
} else {
    configPath := "config.json"
}

; Fall back to default if the file doesn't exist
if !(A_Args.Length = 1 && FileExist(configPath)) {
    LoggerInstance.warn("Failed to load " configPath ". Reverting to config.json")
    configPath := "config.json"
}
; Now read the config JSON
try {
    LoggerInstance.Info("loading " configPath)
    configContent := FileRead(configPath, "UTF-8")
    Users := importuser(configPath)
} catch {
    LoggerInstance.warn("Failed to load " configPath)
    LoggerInstance.Warn("Crash importing users: " e.Message)
    QuitGame(2)
}

;image Stats
LoadImageStatsFromCSV()

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

if debug = false AND GetOCRRegion = false {
    StartDarkWar()
}
;

; ======= Debugging =======
CheckDebug()

; Special
Sleep(2000)

if Screens.mains.Healing.WaitForMatch(250) {
    LoggerInstance.Info("Healing found, starting Healing")
    Hospital()
    ExitApp()
}
Hospital()

if Screens.Shelter.World.WaitForMatch(250) {
    LoggerInstance.Info("World screen detected, starting Boomers")
    boomers()
    ExitApp
}

;sorts users

;Login and start

for u in Users {
    LoggerInstance.info("Starting User: " u.name)
    done := false

    loop {

        try {
            loop {
                LoggerInstance.Debug("Starting logging loop")
                LoggerInstance.info("Game is loading...")
                LoadingWait()
                LoggerInstance.info("Starting splash...")
                splash()
                LoggerInstance.debug("Crash detection")
                CrashDetection()
                LoggerInstance.info("Logging in as: " u.name)
            } until LoginAndSetUser(u)

            Complete_run(u)
            done := true
        } catch as e {
            LoggerInstance.Warn("Crash detected for user " u.name ": " e.Message)
            LoggerInstance.debug(e.Stack)
            TakeScreenshot()
            CrashDetection()
        }
    } until done
}

Complete_run(u) {
    LoggerInstance.info("Starting main loop for user" u.name ": -Boomers:" u.boomer_run " -Energy:" u.energy_run)
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
    Escorts()

    ;Combat
    LoggerInstance.info("Combat")
    CrashDetection()
    iconHelpClick()
    combat()

    ;Alliance
    LoggerInstance.info("Alliance")
    CrashDetection()
    iconHelpClick()
    Alliance()

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
    Expeditions()

    ;Season Management
    CrashDetection()
    iconHelpClick()
    SeasonMgt()

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

    ;Pack Shop
    LoggerInstance.info("VIP")
    CrashDetection()
    iconHelpClick()
    vip()

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

    ;Pack Shop
    LoggerInstance.info("Pack Shop")
    CrashDetection()
    iconHelpClick()
    pack_shop()

    ;End script
    LoggerInstance.info("Ending script")
    CrashDetection()
    iconHelpClick()
}

QuitGame(0)

; ===== HOTKEY: ESC to exit =====
Esc:: {
    BlockInput("MouseMoveOff")
    BlockInput("Off")
    WinSetAlwaysOnTop(0, winTitle)
    ExitApp()
}
