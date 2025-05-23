#Requires AutoHotkey v2.0

OutputDebug "loading"

/* 
====== Includes ======
*/

;config
#Include config.ahk

;libraries
#Include lib/logger.ahk
#Include lib/imagefinder.ahk

;actions


LoggerInstance := Logger(A_ScriptDir "\run.log", "DEBUG")

LoggerInstance.Info("Starting script - " A_ScriptDir)

ImageFinderInstance := ImageFinder(A_ScriptDir "\assets\images\")

ImageFinderInstance.FindImage("switch_NIILeBalafre.bmp", [0, 0, 1920, 1080], 0, 1000, true)

for User in Users {

    }
