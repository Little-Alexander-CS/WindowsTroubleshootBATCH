@echo off
color 1F
title Windows Recovery Batch File by Alexander Little
mode 180, 60
:start
cls
echo.
echo         Starting Windows Recovery Batch File by Alexander Little...
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
echo Choose an option:
echo.
echo     [1] Basic DISM Scan
echo     [2] Advanced DISM Scan
echo     [3] SFC Scan
echo     [4] Clear Cache
echo     [5] Disk Cleanup
echo     [6] Defragment Drives
echo     [7] Resource Monitor
echo     [8] Task Manager
echo     [9] DNS Flush/Renew
echo     [10] Ping loopback IP / 1.1.1.1
echo     [11] Winget Update Service
echo     [12] Reset TCP/IP Stack
echo     [13] Check Disk for Errors (CHKDSK)
echo     [14] Check for Windows Updates
echo     [15] Open Event Viewer
echo     [16] Open Device Manager
echo     [17] Create a System Restore Point
echo     [Q] Quit
echo.

set /p choicevar="Enter your choice (1-17, Q): "

if /i %choicevar% EQU 1 goto restorebasic
if /i %choicevar% EQU 2 goto restoreadvanced
if /i %choicevar% EQU 3 goto sfcscan
if /i %choicevar% EQU 4 goto cacheclear
if /i %choicevar% EQU 5 goto diskcleanup
if /i %choicevar% EQU 6 goto defragment
if /i %choicevar% EQU 7 goto resourcemonitor
if /i %choicevar% EQU 8 goto taskmgr
if /i %choicevar% EQU 9 goto dnsflush
if /i %choicevar% EQU 10 goto pingip
if /i %choicevar% EQU 11 goto update
if /i %choicevar% EQU 12 goto tcpipreset
if /i %choicevar% EQU 13 goto chkdsk
if /i %choicevar% EQU 14 goto windowsupdate
if /i %choicevar% EQU 15 goto eventviewer
if /i %choicevar% EQU 16 goto devicemanager
if /i %choicevar% EQU 17 goto createrestorepoint
if /i %choicevar% EQU Q goto quit
echo Invalid Option, please try again
pause
goto start

:restorebasic
echo "Starting Basic DISM Scan..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth"
echo "Finished..."
pause
goto start

:restoreadvanced
echo "Starting Advanced DISM Scan..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows"
echo "Finished..."
pause
goto start

:sfcscan
cmd /c "sfc /scannow"
echo "Finished..."
pause
goto start

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
goto start

:diskcleanup
start /d "C:\WINDOWS\system32" cleanmgr.exe
echo "Finished..."
pause
goto start

:defragment
start /d "C:\WINDOWS\system32" dfrgui.exe
echo "Finished..."
pause
goto start

:resourcemonitor
echo Set objWMIService = GetObject("winmgmts:"^) > temp.vbs
echo Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'perfmon.exe'"^) >> temp.vbs
echo WScript.Echo colProcesses.Count >> temp.vbs
for /f %%i in ('cscript //nologo temp.vbs') do set process_count=%%i
del temp.vbs

if %process_count% GTR 0 (
    echo "The Resource Monitor is already running."
    pause
    goto start
) else (
    echo "Launching Resource Monitor..."
    start /d "C:\WINDOWS\system32" perfmon.exe
    echo "Finished..."
    pause
    goto start
)

:taskmgr
start /d "C:\WINDOWS\system32" Taskmgr.exe
echo "Finished..."
pause
goto start

:dnsflush
cmd /c "ipconfig /flushdns"
cmd /c "ipconfig /renew"
cmd /c "ipconfig /displaydns"
echo "Finished..."
pause
goto start

:pingip
cmd /c "ping 127.0.0.1"
cmd /c "ping 1.1.1.1"
cmd /c "ipconfig /all"
pause
goto start

:update
echo "Checking for updates..."
cmd /c winget upgrade --include-unknown
echo "Finished..."
set /p startOverPS="Would you like to proceed with these updates? [N - NO, YES - Y / OTHER]: "
IF /i %startOverPS% EQU N goto start
echo "Installing updates..."
cmd /c winget upgrade --all --accept-source-agreements --include-unknown
echo "Finished..."
pause
goto start

:tcpipreset
echo "Resetting TCP/IP Stack..."
cmd /c "netsh int ip reset"
cmd /c "netsh winsock reset"
echo "Finished..."
pause
goto start

:chkdsk
echo "Checking Disk for Errors (CHKDSK)..."
echo "Warning: This will require a restart if errors are found."
cmd /c "chkdsk C: /f /r /x"
echo "Finished..."
pause
goto start

:windowsupdate
echo "Checking for Windows Updates..."
powershell.exe -NoProfile -Command "& {Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Install-Module PSWindowsUpdate -Force -Confirm:$False; Get-WindowsUpdate}"
echo "Finished..."
pause
set /p proceedWithUpdates="Would you like to proceed with these updates? [Y - YES, N - NO]: "
IF /i %proceedWithUpdates% EQU N goto start
echo "Installing Windows Updates..."
powershell.exe -NoProfile -Command "& {Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; Install-Module PSWindowsUpdate -Force -Confirm:$False; Install-WindowsUpdate -AcceptAll -IgnoreReboot}"
echo "Finished..."
pause
goto start


:eventviewer
echo "Opening Event Viewer..."
start /max "Event Viewer" /d "C:\WINDOWS\system32" eventvwr.exe
echo "Finished..."
pause
goto start

:devicemanager
start /d "C:\WINDOWS\system32" devmgmt.msc
echo "Finished..."
pause
goto start

:createrestorepoint
echo Set objWMIService = GetObject("winmgmts:"^) > temp.vbs
echo Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'SystemPropertiesProtection.exe'"^) >> temp.vbs
echo WScript.Echo colProcesses.Count >> temp.vbs
for /f %%i in ('cscript //nologo temp.vbs') do set process_count=%%i
del temp.vbs

if %process_count% GTR 0 (
    echo "The Create a System Restore Point application is already running."
    pause
    goto start
) else (
    echo "Launching Create a System Restore Point..."
    start /d "C:\WINDOWS\system32" SystemPropertiesProtection.exe
    echo "Finished..."
    pause
    goto start
)

:quit
exit

