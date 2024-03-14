@echo off

REM Set color to green
color 0A

REM Prompt user with a menu to select action
echo Process Killer
echo 1. Enter the process ID to kill
echo 2. Exit

REM Read user input
set /p choice=Select an action (1 or 2):

REM Perform action based on user input
if "%choice%"=="1" (
    :input_loop
    set /p process_id=Enter the Process ID to kill:

    REM Check if the process ID is empty
    if "%process_id%"=="" (
        echo Process ID cannot be empty.
        goto input_loop
    ) else (
        REM Check if the process ID exists
        powershell -Command "(Get-Process -Id %process_id% -ErrorAction SilentlyContinue) -ne $null"
        if %ERRORLEVEL% EQU 0 (
            REM Attempt to kill the process
            taskkill /F /PID %process_id%
            if ERRORLEVEL 1 (
                echo Failed to kill process with ID %process_id%.
            ) else (
                echo Process with ID %process_id% killed successfully.
            )
        ) else (
            echo Process with ID %process_id% does not exist.
        )
    )
) else if "%choice%"=="2" (
    echo Exiting...
    exit /b
) else (
    echo Invalid choice. Exiting...
    exit /b
)

REM Pause the script to keep it open
pause
