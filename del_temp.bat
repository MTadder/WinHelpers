@ECHO OFF
ECHO Clearing temporary Windows files...
CD /d %TEMP%
DEL %TEMP%\* /S /Q
ECHO.
ECHO Cleared temporary Windows files!
@ECHO ON
