@echo off
cd /d "%~dp0"
title PM3Max-OpenFW - Flash firmware v4.20728 (legacy compatible)

set EXE=..\client\proxmark3.exe
if not exist "%EXE%" (
  where proxmark3.exe >nul 2>&1
  if not errorlevel 1 set EXE=proxmark3.exe
)
if not exist "%EXE%" (
  echo [ERROR] proxmark3.exe not found.
  echo.
  echo Put a PM3 client into a "client" folder next to this "flash"
  echo folder, or add it to PATH.
  echo.
  pause
  exit /b 1
)

echo ============================================
echo   PM3Max-OpenFW - flash firmware v4.20728
echo   (compatible with the vendor PC client)
echo ============================================
echo.
echo  1. If the device runs v4.23346 or newer:
echo     HOLD the side button, plug in the USB cable,
echo     keep holding until flashing starts.
echo  2. Otherwise just plug in the cable normally.
echo.
echo  Find the port number in Device Manager ^(Ports - COM^).
echo.
set num=
set /p num=  Enter COM port NUMBER (e.g. 8 for COM8):
if "%num%"=="" (
  echo No port given, aborted.
  pause
  exit /b 1
)
echo.
echo Flashing COM%num% ...
"%EXE%" com%num% --flash --image "..\firmware\fullimage_v4.20728_pm3max.elf" --force
echo.
echo Done. Unplug and replug the cable WITHOUT the button,
echo then connect and run "hw version" to verify.
pause
