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
GetOCRRegion := false

debugimage := true
debugimage := false

debugmodeOCRDeeper := false
debugmodeOCR := false
/*
====== Includes ======
*/
;config
#Include src\config.ahk
#Include src\regions.ahk
#include src\GlobalImages.ahk

;libraries
#include src\lib\logger.ahk
#include src\lib\imagefinder.ahk
#include src\lib\clicks.ahk
#include src\lib\loadingwait.ahk
#include src\lib\CrashDetection.ahk
#include src\lib\Reddot.ahk
#include src\lib\json.ahk
#Include src\lib\userimport.ahk
#include src\lib\OCR.ahk
#Include src\lib\FindText.ahk
#Include src\lib\ImageStats.ahk
#Include src\lib\PixelSearch.ahk
#include src\lib\Screenshot.ahk

;special
#Include src\lib\debug.ahk

;classes
#include src\classes\image.ahk
#Include src\classes\user.ahk
#Include src\classes\screen.ahk

;actions
#include src\actions\claim.ahk
#include src\actions\login.ahk
#include src\actions\back.ahk
#include src\actions\shelter.ahk
#include src\actions\icons.ahk
#include src\actions\alliance.ahk
#include src\actions\food.ahk
#include src\actions\Expeditions.ahk
#include src\actions\boomer.ahk
#include src\actions\Combat.ahk
#include src\actions\optimise.ahk
#include src\actions\BattleRewards.ahk
#include src\actions\task.ahk
#include src\actions\Energy.ahk
#include src\actions\splash.ahk
#include src\actions\escort.ahk
#include src\actions\StartGame.ahk
#include src\actions\Events.ahk
#include src\actions\levelup.ahk
;#include src\actions\premium.ahk
#include src\actions\Hospital.ahk
#Include src\actions\Seasonmgt.ahk

#Include src/main.ahk