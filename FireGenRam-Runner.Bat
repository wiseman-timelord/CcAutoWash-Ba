@echo off

:: Initialization - Possibly Customize Title For Viewers Used
mode 45,18
color 80
title FireGenRam-Runner
cls
cd /d "%~dp0"
echo.
echo Script Initialized...
echo.
timeout /t 1 /nobreak > NUL

:: Mount RAM Drive - Customize Line For RamDrive Software Used
echo.
echo Mounting RAM Drive...
"C:\Program Files\SoftPerf RAM Disk\ramdisk.exe" /mount:S
if "%ERRORLEVEL%"=="0" (
    echo ..RAM Drive Mounted.
) else (
    echo ..Failed to Mount RAM Drive!
	pause
    exit /b 1
)
timeout /t 1 /nobreak > NUL
echo.

:: Run Viewer - Customize Executables/Prints For Viewers Used
echo Checking Viewer...
if exist ".\GenesisViewer.exe" (
    echo ..Genesis Present.
    echo Executing, Do Not Close..
    ".\GenesisViewer.exe"
    echo ..Genesis Exited!
    timeout /t 3 /nobreak > NUL
    echo.
) else (
    echo ..Genesis Missing! Checking for Firestorm.
    if exist ".\Firestorm-Releasex64.exe" (
        echo ..Firestorm Present.
        echo Executing, Do Not Close..
        ".\Firestorm-Releasex64.exe"
        echo ..Firestorm Exited!
        timeout /t 3 /nobreak > NUL
        echo.
    ) else (
        echo ..Firestorm Missing! Set Location/ExeName.
        echo.
        timeout /t 3 /nobreak > NUL
        goto unmount
    )
)

:: Unmount RAM Drive - Customize Line For RamDrive Software Used
:unmount
echo Closing Explorer..
powershell -Command "Get-Process -Name explorer | Where-Object { $_.MainWindowHandle -ne 0 } | Stop-Process"
echo ..Explorer Closed.
echo.
echo UnMounting RAM Drive..
"C:\Program Files\SoftPerf RAM Disk\ramdisk.exe" /unmount:S
if "%ERRORLEVEL%"=="0" (
    echo ..RAM Drive UnMounted.
) else (
    echo ..Failed To Unmount!
    timeout /t 3 /nobreak > NUL
)
echo.
timeout /t 1 /nobreak > NUL

:: Outro - Fine How It Is, No Changes Needed
echo.
echo ...Processes Complete.
timeout /t 5 /nobreak > NUL
exit
