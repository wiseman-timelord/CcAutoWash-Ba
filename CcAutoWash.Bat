@echo off

:: Initialization
title CcAutoWash
mode 30,11
color 80
cd /d "%~dp0"
set "scriptDir=%~dp0"
echo.
echo Script Initialized...
echo.
echo.

:: Introduction
echo CcAutoWash In 10s..
timeout /t 10 /nobreak >nul

:: Start Cleaning
echo ..Executing CCleaner..
"%scriptDir%CCleaner64.exe" /AUTO
echo ..Cleaning Complete.
echo.

:: Script Exit
echo.
echo ...Script Complete.
timeout /t 5 /nobreak >nul
exit
