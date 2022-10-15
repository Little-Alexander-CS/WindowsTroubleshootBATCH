@echo off
echo "Starting windows recovery batch file by Alexander Little..."

echo "Begining inital scan..."
rem cmd /c "sfc /scannow"
echo "Completed..."

set /p _inputname = "REGULAR RESTORE [1] OR ADVANCED RESTORE [2] "
IF ("%_inputname%"== hi) goto :advanced_restore
echo "Starting regular recovery..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth"
goto :end
:advanced_restore
echo "Starting advanced recovery..."
cmd /c "DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows"
:end

echo "Windows recovery completed..."

echo "Starting Windows Cache Clear..."

del /s /f /q C:\Windows\Prefetch*.*
del /s /f /q C:\Windows\Temp*.*
del /s /f /q C:\%alexa%\appdata\local\temp*.*

echo "Finished...!"
