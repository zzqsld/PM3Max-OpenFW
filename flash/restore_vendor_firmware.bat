@echo off
cd /d "%~dp0"
title PM3Max-OpenFW - Restore vendor official firmware

set IMG=..\firmware\vendor_fullimage.elf
if not exist "%IMG%" (
  echo [ERROR] Vendor firmware image not found:
  echo   %IMG%
  echo.
  echo The vendor image is NOT redistributed with this package.
  echo Copy "fullimage.elf" from the official vendor client folder
  echo into the "firmware" folder and rename it to:
  echo   vendor_fullimage.elf
  echo then run this script again.
  echo.
  pause
  exit /b 1
)

set EXE=..\client\proxmark3.exe
if not exist "%EXE%" (
  where proxmark3.exe >nul 2>&1
  if not errorlevel 1 set EXE=proxmark3.exe
)
if not exist "%EXE%" (
  echo [ERROR] proxmark3.exe not found.
  echo Put a PM3 client into a "client" folder next to this "flash"
  echo folder, or add it to PATH.
  echo.
  pause
  exit /b 1
)

echo ============================================
echo   Restore vendor official firmware (os only)
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
"%EXE%" com%num% --flash --image "%IMG%" --force
echo.
echo Done. Unplug and replug the cable WITHOUT the button.
pause
