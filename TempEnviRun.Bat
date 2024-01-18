@echo off

:: Initialization
title PACT_Interface_Execution
rem mode 60,30
color 0E
cd /d "%~dp0"
set "scriptDir=%~dp0"
echo.
echo Script Initialized...
echo.
echo.

:: Environment Setup
echo Setting Temporary Dirs..
SET TMP=SsdDrive:\TempLocation
SET TEMP=SsdDrive:\TempLocation
echo ..Temporary Directories Set.
echo.
timeout /t 1 /nobreak >nul

:: Running Executable
echo Launching Target Program..
echo ...Executing PACT_Interface.exe...
rem "%scriptDir%TargetApplication.exe"  <--- ONE OF THESE LINES
rem python "%scriptDir%YourPythonScript.py"  <--- ONE OF THESE LINES
echo ..Execution Complete.
echo.
timeout /t 1 /nobreak >nul

:: Script Exit
echo.
echo ...Script Complete.
PAUSE
exit