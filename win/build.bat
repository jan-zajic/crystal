SET BAT_FILE_DIR=%~dp0
CALL %BAT_FILE_DIR%\winBuild.bat
CALL %BAT_FILE_DIR%\winLink.bat
