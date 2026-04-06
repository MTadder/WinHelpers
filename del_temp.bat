@ECHO OFF
ECHO Clearing temporary Windows files...
CD /d %TEMP%
DEL * /S /Q
ECHO.
ECHO Cleared temporary Windows files!
@ECHO ON
