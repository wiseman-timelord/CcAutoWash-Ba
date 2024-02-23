@echo off


:: Initialization - Possibly Customize Title For Viewers Used
setlocal enabledelayedexpansion
mode 45,25
color 80
title FireGenRam-Runner
cls
cd /d "%~dp0"
set "explorerWindowsOpen=0"
set "explorerPath=C:\"
echo.
echo Script Initialized...
echo.
timeout /t 1 /nobreak > NUL

:: Mount RAM Drive - Customize Line For RamDrive Software Used
echo.
echo Mounting RAM Drive...
"C:\Program Files\SoftPerf RAM Disk\ramdisk.exe" /mount:S
if "!ERRORLEVEL!"=="0" (
    echo ..RAM Drive Mounted.
) else (
    echo ..Failed to Mount RAM Drive!
	pause
    exit /b 1
)
timeout /t 1 /nobreak > NUL
echo.

:: Run Viewer - Customize Executables/Prints For Viewers Used
echo Checking Viewers...
if exist ".\GenesisViewer.exe" (
    echo ..Genesis Present..
    echo ..Executing Genesis..
	echo ^(Don't Close This Window^)
    ".\GenesisViewer.exe"
    echo ..Genesis Exited!
    timeout /t 2 /nobreak > NUL
    echo.
) else (
    if exist ".\Firestorm-Releasex64.exe" (
        echo ..Firestorm Present..
        echo ..Executing Firestorm..
	    echo ^(Don't Close This Window^)
        ".\Firestorm-Releasex64.exe"
		echo ..Firestorm Exited!
		echo.
        timeout /t 2 /nobreak > NUL
		goto unmount
    ) else (
        echo ..Firestorm & Genesis, Missing!
        echo.
        timeout /t 3 /nobreak > NUL
        goto unmount
    )
)

:: Unmount RAM Drive - Customize Line For RamDrive Software Used
:unmount
echo Checking Explorer..
for /f "delims=" %%i in ('powershell -Command "$shell = New-Object -ComObject shell.application; $shell.Windows() | Where-Object { $_.HWND -ne 0 -and $_.FullName -match 'explorer\.exe$' } | ForEach-Object { $location = ''; try { $location = $_.Document.Folder.Self.Path } catch {}; if ($location) { Write-Output $location; break; } }"') do set "explorerPath=%%i"
if not "!explorerPath!"=="C:\" (
    set "explorerWindowsOpen=1"
    powershell -Command "Get-Process explorer | Where-Object { $_.MainWindowHandle -ne 0 } | ForEach-Object { Stop-Process -Id $_.Id }"
    echo ..Explorer Closed.
) else (
    echo ..No Explorers Open.
)
echo.
timeout /t 1 /nobreak > NUL
echo UnMounting RamDrive..
"C:\Program Files\SoftPerf RAM Disk\ramdisk.exe" /unmount:S
if "!ERRORLEVEL!"=="0" (
    echo ..RamDrive UnMounted..
) else (
    echo ..Failed To Unmount!
)
timeout /t 3 /nobreak > NUL
if !explorerWindowsOpen! equ 1 (
    echo.
    echo Re-Opening Explorer..
    powershell -Command "$path = '!explorerPath!'.Replace('file:///', '').Replace('/', '\'); $path = [System.Uri]::UnescapeDataString($path); if (Test-Path \"$path\") { Start-Process 'explorer.exe' -ArgumentList \"/n,/e,$path\" } else { Start-Process 'explorer.exe' }"
    echo ..Explorer Opened.
)
echo.
timeout /t 1 /nobreak > NUL

:: Outro - Fine How It Is, No Changes Needed
echo.
echo ...Processes Complete.
timeout /t 5 /nobreak > NUL
endlocal
exit
