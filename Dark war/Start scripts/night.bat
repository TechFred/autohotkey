@echo off
:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Running as admin...
    powershell -Command "Start-Process '%~dp0..\run.exe' -ArgumentList 'night.json' -Verb RunAs"
    exit /b
)

:: Already admin, run the command
"%~dp0..\run.exe" night.json


:: Wait for a moment (optional)
timeout /t 3 >nul

:: Put the computer to sleep
rundll32.exe powrprof.dll,SetSuspendState 0,1,0

::  "Start-Process '%~dp0..\run.exe' -ArgumentList 'night.json' -Verb RunAs -Wait"
