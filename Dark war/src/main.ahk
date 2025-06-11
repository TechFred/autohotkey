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
    config := JSON.Parse(configContent)
} catch {
    LoggerInstance.warn("Failed to load " configPath)
    ExitApp
}

;image Stats
LoadImageStatsFromCSV()

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

if debug = false AND GetOCRRegion = false {
    StartDarkWar()
}
;

; ======= Debugging =======
CheckDebug()

; Special
Sleep(2000)
Hospital()

if getCurrentScreen() = SCREEN_WORLD {
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

LoggerInstance.Info("Done")

ExitApp()

; ===== HOTKEY: ESC to exit =====
Esc:: {
    BlockInput("MouseMoveOff")
    BlockInput("Off")
    WinSetAlwaysOnTop(0, winTitle)
    ExitApp()
}
