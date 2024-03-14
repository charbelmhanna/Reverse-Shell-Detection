@echo off

REM Define the path to the PowerShell script
set "powershell_script=detect_and_kill_reverse_shell.ps1"

REM Execute the PowerShell script
powershell -ExecutionPolicy Bypass -File "%powershell_script%"

REM Pause to keep the command prompt window open (optional)
pause
