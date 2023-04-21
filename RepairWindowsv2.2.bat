@echo off
title Windows 10/11 Troubleshooting Batch File (Alexander Little)
mode 180, 60
call :isAdmin

 if %errorlevel% == 0 (
    goto :run
 ) else (
    echo Requesting administrative privileges...
    goto :UACPrompt
 )

 exit /b

 :isAdmin
    fsutil dirty query %systemdrive% >nul
 exit /b

 :run
goto main_menu

:main_menu
cls
echo.
echo Starting Windows 10/11 Troubleshooting Batch File by Alexander Little...
echo ===================================================================
echo.
echo                                            .oodMMMM
echo                                   .oodMMMMMMMMMMMMM
echo                       ..oodMMM  MMMMMMMMMMMMMMMMMMM
echo                 oodMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo. 
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                    `^^^^^^MMMMMMM  MMMMMMMMMMMMMMMMMMM
echo                          ````^^^^  ^^MMMMMMMMMMMMMMMMM
echo                                         ````^^^^^^MMMM
echo Choose a category:
echo.
echo     [1] Network
echo     [2] Application
echo     [3] Scanning
echo     [4] Maintenance
echo     [Q] Quit
echo.

set /p category_choice="Enter your choice (1-4, Q): "

:: Validate user input
set "valid_categories=1 2 3 4 Q"
echo %valid_categories%|find "%category_choice%" >nul || (
    echo Invalid Option, please try again
    pause
    goto main_menu
)

if /i %category_choice% EQU 1 goto network_menu
if /i %category_choice% EQU 2 goto application_menu
if /i %category_choice% EQU 3 goto scanning_menu
if /i %category_choice% EQU 4 goto maintenance_menu
if /i %category_choice% EQU Q goto quit

:network_menu
cls
echo.
echo Network Menu:
echo.
echo     [1] DNS Flush/Renew
echo     [2] Ping loopback IP / 1.1.1.1
echo     [3] Reset TCP/IP Stack
echo     [B] Back
echo.

set /p network_choice="Enter your choice (1-3, B): "

:: Validate user input
set "valid_choices=1 2 3 B"
echo %valid_choices%|find "%network_choice%" >nul || (
    echo Invalid Option, please try again
    pause
    goto network_menu
)

if /i %network_choice% EQU 1 goto dnsflush
if /i %network_choice% EQU 2 goto pingip
if /i %network_choice% EQU 3 goto tcpipreset
if /i %network_choice% EQU B goto main_menu

:application_menu
cls
echo.
echo Application Menu:
echo.
echo     [1] Task Manager
echo     [2] Event Viewer
echo     [3] Device Manager
echo     [B] Back
echo.

set /p app_choice="Enter your choice (1-3, B): "

:: Validate user input
set "valid_choices=1 2 3 B"
echo %valid_choices%|find "%app_choice%" >nul || (
    echo Invalid Option, please try again
    pause
    goto application_menu
)

if /i %app_choice% EQU 1 goto taskmgr
if /i %app_choice% EQU 2 goto eventviewer
if /i %app_choice% EQU 3 goto devicemanager
if /i %app_choice% EQU B goto main_menu

:scanning_menu
cls
echo.
echo Scanning Menu:
echo
echo.
echo Scanning Menu:
echo.
echo     [1] Basic DISM Scan
echo     [2] Advanced DISM Scan
echo     [3] SFC Scan
echo     [4] Check Disk for Errors (CHKDSK)
echo     [B] Back
echo.

set /p scan_choice="Enter your choice (1-4, B): "

set "valid_choices=1 2 3 4 B"
echo %valid_choices%|find "%scan_choice%" >nul || (
    echo Invalid Option, please try again
    pause
    goto scanning_menu
)

if /i %scan_choice% EQU 1 goto restorebasic
if /i %scan_choice% EQU 2 goto restoreadvanced
if /i %scan_choice% EQU 3 goto sfcscan
if /i %scan_choice% EQU 4 goto chkdsk
if /i %scan_choice% EQU B goto main_menu

:maintenance_menu
cls
echo.
echo Maintenance Menu:
echo.
echo     [1] Clear Cache
echo     [2] Disk Cleanup
echo     [3] Defragment Drives
echo     [4] Resource Monitor
echo     [5] Check for Windows Updates
echo     [6] Create a System Restore Point
echo     [7] Winget Update Service
echo     [8] Clear ARP Cache
echo     [B] Back
echo.

set /p maint_choice="Enter your choice (1-8, B): "

:: Validate user input
set "valid_choices=1 2 3 4 5 6 7 8 B"
echo %valid_choices%|find "%maint_choice%" >nul || (
    echo Invalid Option, please try again
    pause
    goto maintenance_menu
)

if /i %maint_choice% EQU 1 goto cacheclear
if /i %maint_choice% EQU 2 goto diskcleanup
if /i %maint_choice% EQU 3 goto defragment
if /i %maint_choice% EQU 4 goto resourcemonitor
if /i %maint_choice% EQU 5 goto windowsupdate
if /i %maint_choice% EQU 6 goto createrestorepoint
if /i %maint_choice% EQU 7 goto update
if /i %maint_choice% EQU 8 goto arp_cache
if /i %maint_choice% EQU B goto main_menu

:restorebasic
echo "Starting Basic DISM Scan..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth"
echo "Finished..."
pause
goto scanning_menu

:restoreadvanced
echo "Starting Advanced DISM Scan..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows"
echo "Finished..."
pause
goto scanning_menu

:sfcscan
cmd /c "sfc /scannow"
echo "Finished..."
pause
goto scanning_menu

:cacheclear
echo "Clearing Cache..."
cd /d %systemroot%\temp
del /q /f /s *.*
cd /d %temp%
del /q /f /s *.*
cd /d %systemroot%\Prefetch
del /q /f /s *.*
echo "Finished..."
pause
goto maintenance_menu

:diskcleanup
start /d "C:\WINDOWS\system32" cleanmgr.exe
echo "Finished..."
pause
goto maintenance_menu

:defragment
start /d "C:\WINDOWS\system32" dfrgui.exe
echo "Finished..."
pause
goto maintenance_menu

:resourcemonitor
echo Set objWMIService = GetObject("winmgmts:"^) > temp.vbs
echo Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'perfmon.exe'"^) >> temp.vbs
echo WScript.Echo colProcesses.Count >> temp.vbs
for /f %%i in ('cscript //nologo temp.vbs') do set process_count=%%i
del temp.vbs

if %process_count% GTR 0 (
    echo "The Resource Monitor is already running."
    pause
    goto maintenance_menu
) else (
    echo "Launching Resource Monitor..."
    start /d "C:\WINDOWS\system32" perfmon.exe
    echo "Finished..."
    pause
    goto maintenance_menu
)

:taskmgr
start /d "C:\WINDOWS\system32" Taskmgr.exe
echo "Finished..."
pause
goto application_menu

:dnsflush
start cmd /k "ipconfig /displaydns > %USERPROFILE%\Downloads\displaydns_before_flush.txt && ipconfig /flushdns && ipconfig /renew && ipconfig /displaydns > %USERPROFILE%\Downloads\displaydns_after_flush.txt"
echo "Finished..."
pause
goto network_menu

:pingip
cmd /c "ping 127.0.0.1"
cmd /c "ping 1.1.1.1"
start cmd.exe /k cmd /c "ipconfig /all"
pause
goto network_menu

:update
echo "Checking for updates..."
cmd /c winget upgrade --include-unknown
echo "Finished..."
set /p startOverPS="Would you like to proceed with these updates? [N - NO, YES - Y / OTHER]: "
IF /i %startOverPS% EQU N goto maintenance_menu
echo "Installing updates..."
cmd /c winget upgrade --all --accept-source-agreements --include-unknown
echo "Finished..."
pause
goto maintenance_menu

:tcpipreset
echo "Resetting TCP/IP Stack..."
cmd /c "netsh int ip reset"
cmd /c "netsh winsock reset"
echo "Finished..."
pause
goto network_menu

:chkdsk
echo "Checking Disk for Errors (CHKDSK)..."
echo "Warning: This will require a restart if errors are found."
cmd /c "chkdsk C: /f /r /x"
echo "Finished..."
pause
goto scanning_menu

:windowsupdate
echo "Checking for Windows Updates..."
powershell.exe -NoProfile -Command "& {Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Install-Module PSWindowsUpdate -Force -Confirm:$False; Get-WindowsUpdate}"
echo "Finished..."
pause
set /p proceedWithUpdates="Would you like to proceed with these updates? [Y - YES, N - NO]: "
IF /i %proceedWithUpdates% EQU N goto maintenance_menu
echo "Installing Windows Updates..."
powershell.exe -NoProfile -Command "& {Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Install-Module PSWindowsUpdate -Force -Confirm:$False; Install-WindowsUpdate -AcceptAll -IgnoreReboot}"
echo "Finished..."
pause
goto maintenance_menu

:eventviewer
echo "Opening Event Viewer..."
start /max "Event Viewer" /d "C:\WINDOWS\system32" eventvwr.exe
echo "Finished..."
pause
goto application_menu

:devicemanager
start /d "C:\WINDOWS\system32" devmgmt.msc
echo "Finished..."
pause
goto application_menu

:createrestorepoint
echo Set objWMIService = GetObject("winmgmts:"^) > temp.vbs
echo Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'SystemPropertiesProtection.exe'"^) >> temp.vbs
echo WScript.Echo colProcesses.Count >> temp.vbs
for /f %%i in ('cscript //nologo temp.vbs') do set process_count=%%i
del temp.vbs

if %process_count% GTR 0 (
    echo "The Create a System Restore Point application is already running."
    pause
    goto maintenance_menu
) else (
    echo "Launching Create a System Restore Point..."
    start /d "C:\WINDOWS\system32" SystemPropertiesProtection.exe
    echo "Finished..."
    pause
    goto maintenance_menu
)
 exit /b

:arp_cache
cls
echo Displaying ARP cache...
start cmd.exe /k cmd /c "arp -a"
echo.
echo Clearing ARP cache...
cmd /c arp -d *
echo ARP cache cleared.
pause
goto maintenance_menu

 :UACPrompt
   echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
   echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"
   "%temp%\getadmin.vbs"
   del "%temp%\getadmin.vbs"
  exit /B`
