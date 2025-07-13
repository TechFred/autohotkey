@echo off
:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Running as admin...
    powershell -Command "Start-Process '%~dp0..\run.exe' -ArgumentList 'day.json' -Verb RunAs"
    exit /b
)

:: Already admin, run the command
"%~dp0..\run.exe" day.json
