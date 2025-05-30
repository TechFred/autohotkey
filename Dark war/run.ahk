#Requires AutoHotkey v2.0
#Warn All, OutputDebug

CoordMode "Mouse", "Client"
SetWorkingDir(A_ScriptDir)

OutputDebug "Starting script - " A_ScriptDir
O_NIILeBalafre := Image("switch_NIILeBalafre.bmp", 50, Regions.AllRegion)
O_Balafre := Image("switch_balafre.bmp", 50, Regions.AllRegion)
O_MiniBalafre := Image("switch_minibalafre.bmp", 50, Regions.AllRegion)

Users := [ ;
    { name: "LeBalafré", active: false, state: 148, img: O_NIILeBalafre, order: 1, boomer_run: true, energy_run : true }, ;
    { name: "Balafré", active: false, state: 148, img: O_Balafre, order: 2, boomer_run: true, energy_run : true }, ;
    { name: "MiniBalafré", active: false, state: 148, img: O_MiniBalafre, order: 3, boomer_run: true, energy_run : true }, ;
] ;


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
#include src\lib\GetEnergy.ahk
#include src\lib\loadingwait.ahk
#include src\lib\CrashDetection.ahk
#include src\lib\Reddot.ahk

;classes
#include src\classes\image.ahk

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
#include src\actions\premium.ahk




#Include src/main.ahk