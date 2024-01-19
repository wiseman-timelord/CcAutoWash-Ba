@echo off

:: Initialization
mode 45,18
color 80
title FireDriveRunner
cls
cd /d "%~dp0"
echo.
echo Script Initialized...
echo.
timeout /t 1 /nobreak > NUL

:: Mount RAM Drive
echo.
echo Mounting RAM Drive..
"Drive:\RamDiskSoftwareLocation\RamDiskExecutable" OPTIONS - possibly ramdisk.exe /mount:S  <--- EDIT THIS LINE
if "%ERRORLEVEL%"=="0" (
    echo ..RAM Drive Mounted.
) else (
    echo ..Failed to Mount RAM Drive!
	pause
    exit /b 1
)
timeout /t 1 /nobreak > NUL
echo.

:: Run Target Application
echo Checking Target Application..
if exist ".\TargetApplication.exe" (  <--- EDIT THIS LINE
	echo ..Target Application Present.
    echo Executing, Do Not Close..
	".\TargetApplication.exe"  <--- EDIT THIS LINE
    echo ..Target Application Exited!
    echo.
) else (
    echo ..Missing! Set Location/ExeName.
        echo.
	timeout /t 3 /nobreak > NUL
    goto unmount
)
timeout /t 1 /nobreak > NUL

:: Unmount RAM Drive
:unmount
echo UnMounting RAM Drive..
"Drive:\RamDiskSoftwareLocation\RamDiskExecutable" OPTIONS - possibly ramdisk.exe /unmount:S  <--- EDIT THIS LINE
if "%ERRORLEVEL%"=="0" (
    echo ..RAM Drive UnMounted.
) else (
    echo ..Failed To Unmount!
    timeout /t 3 /nobreak > NUL
)
timeout /t 1 /nobreak > NUL
echo.

:: Outro
echo.
echo ...Processes Complete.
timeout /t 5 /nobreak > NUL
exit
