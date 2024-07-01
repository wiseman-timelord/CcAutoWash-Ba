@echo off
setlocal enabledelayedexpansion

:: Initialization - Possibly Customize Title For Viewers Used
mode 45,25
echo.
echo =============(FireGenRam-Runner)=============
echo.
echo Initializing script..
timeout /t 1 /nobreak > NUL
cd /d "%~dp0"
color 80
title FireGenRam-Runner
set "explorerWindowsOpen=0"
set "explorerPath=C:\"
echo ..Script Initialized..
echo.
timeout /t 2 /nobreak > NUL
cls
echo.
echo =============(FireGenRam-Runner)=============
echo.

:: Mount RAM Drive - Customize Line For RamDrive Software Used
echo Mounting RAM Drive..
rem  enter your ram drive software line here 
"C:\System Files\RAMDisk\ramdisk.exe" /mount:U
if "!ERRORLEVEL!"=="0" (
    echo ..RAM Drive Mounted.
) else (
    echo ..Failed to Mount RAM Drive!
	pause
    exit /b 1
)
timeout /t 1 /nobreak > NUL

:: Grace Period - Fine How It Is, No Changes Needed
echo Waiting 2 seconds..
timeout /t 2 /nobreak > NUL
echo ..Grace Period Over.
timeout /t 1 /nobreak > NUL

:: Run Viewer Loop - Customize Executables/Prints For Non-FS/Gen Viewers
:launchViewer
echo Checking Viewers..
if exist ".\GenesisViewer.exe" (
    echo ..Executing Genesis..
    ".\GenesisViewer.exe"
    echo ..Genesis Exited..
    timeout /t 1 /nobreak > NUL
    goto relog
) else (
    if exist ".\Firestorm-Releasex64.exe" (
        echo ..Executing Firestorm..
        ".\Firestorm-Releasex64.exe"
        echo ..Firestorm Exited..
        timeout /t 1 /nobreak > NUL
        goto relog
    ) else (
        echo ..Firestorm & Genesis, Missing!
        timeout /t 3 /nobreak > NUL
        goto 2ndGrace
    )
)

:: Ask Relog - Fine How It Is, No Changes Needed
:relog 
set /p "relog=..Are You Relogging YN? "
if /i "%relog%"=="y" goto launchViewer

:: Grace Period - Fine How It Is, No Changes Needed
:2ndGrace
echo Waiting 2 seconds..
timeout /t 2 /nobreak > NUL
echo ..Grace Period Over.
timeout /t 1 /nobreak > NUL

:: Unmount RAM Drive - Enhanced Shutdown Code
echo Checking Explorer..
for /f "delims=" %%i in ('powershell -Command "$shell = New-Object -ComObject shell.application; $shell.Windows() | Where-Object { $_.HWND -ne 0 -and $_.FullName -match 'explorer\.exe$' } | ForEach-Object { $location = ''; try { $location = $_.Document.Folder.Self.Path } catch {}; if ($location) { Write-Output $location; break; } }"') do set "explorerPath=%%i"
if not "!explorerPath!"=="C:\" (
    set "explorerWindowsOpen=1"
    powershell -Command "Get-Process explorer | Where-Object { $_.MainWindowHandle -ne 0 } | ForEach-Object { Stop-Process -Id $_.Id }"
    echo ..Explorer Closed.
) else (
    echo ..No Explorers Open.
)
timeout /t 1 /nobreak > NUL

:unmountAttempt
set retries=0
set maxRetries=2

:tryUnmount
echo Unmounting Ramdisk, Attempt !retries!..
rem  enter your ram drive software line here 
"C:\System Files\RAMDisk\ramdisk.exe" /unmount:U
if "!ERRORLEVEL!"=="0" (
    echo ..RAM Drive Unmounted..
) else (
    if !retries! lss !maxRetries! (
        set /a retries+=1
        echo ..Failed unmount, 20s retry..
        timeout /t 20 /nobreak > NUL
        goto tryUnmount
    ) else (
        echo ..Failed !retries! attempts, forcing..
        rem  enter your ram drive software line here 
		"C:\System Files\RAMDisk\ramdisk.exe" /forceunmount:U
        if "!ERRORLEVEL!"=="0" (
            echo ..forcefully unmounted.
        ) else (
            echo ..Failed force unmount!
            pause
            exit /b 1
        )
    )
)
timeout /t 3 /nobreak > NUL

if !explorerWindowsOpen! equ 1 (
    echo.
    echo Re-Opening Explorer..
    powershell -Command "$path = '!explorerPath!'.Replace('file:///', '').Replace('/', '\'); $path = [System.Uri]::UnescapeDataString($path); if (Test-Path \"$path\") { Start-Process 'explorer.exe' -ArgumentList \"/n,/e,$path\" } else { Start-Process 'explorer.exe' }"
    echo ..Explorer Opened.
)
timeout /t 1 /nobreak > NUL

:: Outro - Fine How It Is, No Changes Needed
echo Complete, Exiting...
echo.
timeout /t 5 /nobreak > NUL
endlocal
exit
