#Requires AutoHotkey v2.0
#Warn All, OutputDebug
#WinActivateForce
#SingleInstance

; Windows
winTitle := "ahk_class Qt672QWindowIcon ahk_exe HD-Player.exe"
SetTitleMatchMode(2)

CoordMode "Mouse", "Client"
SetWorkingDir(A_ScriptDir)

OutputDebug "Starting script - " A_ScriptDir

debug := true
debug := false

GetOCRRegion := true
;GetOCRRegion := false

debugimage := true
debugimage := false

debugmodeOCRDeeper := false
debugmodeOCR := false

ForceRestartGame := false
ForceRestartGame := true

/*
====== Includes ======
*/
;config
#Include src\config.ahk
#Include src\regions.ahk
#Include src\GlobalImages.ahk

;libraries
#Include src\lib\logger.ahk
#Include src\lib\imagefinder.ahk
#Include src\lib\clicks.ahk
#Include src\lib\loadingwait.ahk
#Include src\lib\CrashDetection.ahk
#Include src\lib\Reddot.ahk
#Include src\lib\json.ahk
#Include src\lib\userimport.ahk
#Include src\lib\OCR.ahk
#Include src\lib\FindText.ahk
#Include src\lib\ImageStats.ahk
#Include src\lib\PixelSearch.ahk
#Include src\lib\Screenshot.ahk

;special
#Include src\lib\debug.ahk

;classes
#Include src\classes\image.ahk
#Include src\classes\user.ahk
#Include src\classes\screen.ahk

;actions
#Include src\actions\claim.ahk
#Include src\actions\login.ahk
#Include src\actions\back.ahk
#Include src\actions\shelter.ahk
#Include src\actions\icons.ahk
#Include src\actions\alliance.ahk
#Include src\actions\food.ahk
#Include src\actions\Expeditions.ahk
#Include src\actions\boomer.ahk
#Include src\actions\Combat.ahk
#Include src\actions\optimise.ahk
#Include src\actions\BattleRewards.ahk
#Include src\actions\task.ahk
#Include src\actions\Energy.ahk
#Include src\actions\splash.ahk
#Include src\actions\escort.ahk
#Include src\actions\StartGame.ahk
#Include src\actions\Events.ahk
#Include src\actions\levelup.ahk
;#include src\actions\premium.ahk
#Include src\actions\Hospital.ahk
#Include src\actions\Seasonmgt.ahk

#Include src/main.ahk