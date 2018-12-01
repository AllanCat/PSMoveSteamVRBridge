@ECHO off
SETLOCAL

:: Don't pause at the end of the script if requested not to
SET suppressPause=0
IF "%1"=="-nopause" (
    set /A suppressPause=suppressPause+1
)

:: Suppress pause for child scripts
SET /A suppressPause=suppressPause+1

:: Reregister any existing psmove drivers
CALL SteamVR_UnregisterDrivers.bat
IF %ERRORLEVEL% NEQ 0 (goto failure)

:: Un-Suppress pause for child scripts
SET /A suppressPause=suppressPause-1

:: Pause before exit if pause isn't suppressed
ECHO "Uninstallation successful."
IF %suppressPause% EQU 0 (
  PAUSE
)
GOTO exit

:failure
ECHO "Error occured during uninstallation!"
IF %suppressPause% EQU 0 (
  PAUSE
)
EXIT /B %ERRORLEVEL%
GOTO exit

:exit
ENDLOCAL