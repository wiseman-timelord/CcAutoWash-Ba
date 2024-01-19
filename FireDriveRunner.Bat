@echo off

:: Initialization
mode 45,17
color 0A
title FireDriveRunner
cls
cd /d "%~dp0"
echo.
echo Script Initialized...
echo.
timeout /t 1 /nobreak > NUL

:: Mount RAM Drive
echo.
echo Mounting RAM Drive...
"C:\Program Files\SoftPerf RAM Disk\ramdisk.exe" /mount:S
if "%ERRORLEVEL%"=="0" (
    echo ...RAM Drive Mounted.
) else (
    echo ...Failed to Mount RAM Drive!
	pause
    exit /b 1
)
timeout /t 1 /nobreak > NUL
echo.

:: Run Firestorm
echo Launching Firestorm...
if exist ".\Firestorm-Releasex64.exe" (
	echo ...Do Not Close Window...
    echo ...Executing Firestorm...
	".\Firestorm-Releasex64.exe"
    echo ...Firestorm Exited!
) else (
    echo ...Firestorm Missing!
    echo ...Set Correct Location/ExeName.
	timeout /t 3 /nobreak > NUL
    goto unmount
)
echo.
timeout /t 1 /nobreak > NUL

:: Unmount RAM Drive
:unmount
echo.
echo UnMounting RAM Drive...
"C:\Program Files\SoftPerf RAM Disk\ramdisk.exe" /unmount:S
if "%ERRORLEVEL%"=="0" (
    echo ...RAM Drive UnMounted.
) else (
    echo ...Failed To Unmount!
    timeout /t 3 /nobreak > NUL
)
timeout /t 1 /nobreak > NUL
echo.

:: Outro
echo.
echo ...Processes Complete.
timeout /t 5 /nobreak > NUL
exit
