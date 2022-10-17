@echo off
echo "Starting windows recovery batch file by Alexander Little..."

:start
echo "[1] - Basic DISM Scan"
echo "[2] - Advanced DISM Scan"
echo "[3] - SFC Scan"
echo "[4] - Clear Cache"
echo "[5] - Disk Cleanup"
echo "[6] - Defragment Drives"
echo "[7] - Resource Monitor"
echo "[8] - Task Manager"
echo "[9] - DNS Flush/Renew"
echo "[10] - Ping loopback IP / 1.1.1.1"
set /p choicevar="Enter your choice: "

if %choicevar% EQU 1 goto restorebasic
if %choicevar% EQU 2 goto restoreadvanced
if %choicevar% EQU 3 goto sfcscan
if %choicevar% EQU 4 goto cacheclear
if %choicevar% EQU 5 goto diskcleanup
if %choicevar% EQU 6 goto defragment
if %choicevar% EQU 7 goto resourcemonitor
if %choicevar% EQU 8 goto taskmgr
if %choicevar% EQU 9 goto dnsflush
if %choicevar% EQU 10 goto pingip

echo "Invalid Option, please try again"
goto start 
:cacheclear
del /f /q "C:\Windows\Temp\"
rem alexa must be replaced with account name
del /f /q "C:\Users\alexa\AppData\Local\Temp\"
start "" "C:\Windows\Temp\"
start "" "C:\Users\alexa\AppData\Local\Temp\"
echo "Finished..."
goto end
:restorebasic
echo "Starting Basic DISM Scan..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth"
echo "Finished..."
goto end
:restoreadvanced
echo "Starting Advanced DISM Scan..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows"
echo "Finished..."
goto end
:sfcscan
cmd /c "sfc /scannow"
echo "Finished..."
goto end
:diskcleanup
start /d "C:\WINDOWS\system32" cleanmgr.exe
echo "Finished..."
goto end
:defragment
start /d "C:\WINDOWS\system32" dfrgui.exe
echo "Finished..."
goto end
:resourcemonitor
start /d "C:\WINDOWS\system32" perfmon.exe
echo "Finished..."
goto end
:taskmgr
start /d "C:\WINDOWS\system32" Taskmgr.exe
echo "Finished..."
goto end
:dnsflush
cmd /c "ipconfig /flushdns"
cmd /c "ipconfig /renew"
cmd /c "ipconfig /displaydns"
echo "Finished..."
goto end
:pingip
cmd /c "ping 127.0.0.1"
cmd /c "ping 1.1.1.1"
cmd /c "ipconfig /all"
goto end
:end
set /p startOver="Would you like to run another command? [1 - YES, OTHER - NO]: "
IF /i %startOver% EQU 1 goto start

echo "Finished...!"
timeout -1 /nobreak
