@echo off
VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 ECHO Unable to enable extensions

SET BAT_FILE_DIR=%~dp0
SET CRYSTAL_DIR=%BAT_FILE_DIR%\..\
cd %CRYSTAL_DIR%

docker build -f %BAT_FILE_DIR%\Dockerfile -t crystal_win_object .
docker run --rm --entrypoint cat crystal_win_object /opt/crystal/.build/win.o > .build/win.o

ENDLOCAL