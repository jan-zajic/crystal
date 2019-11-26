@echo off
VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 ECHO Unable to enable extensions

IF NOT DEFINED LLVM_BASE_DIR (
	ECHO LLVM_BASE_DIR NOT defined!
	ECHO You MUST compile LLVM from Sources 
	ECHO and set LLVM_BASE_DIR to install target directory
	ECHO where bin/llvm-config.exe exists
	EXIT /B 1
)

IF NOT DEFINED VSCMD_VER (
	ECHO Visual Studio Tools not found!
	ECHO You must install Build Tools for Visual Studio 2017
	ECHO and run this script from "x64 Native Tools Command Prompt"
)

set LLVM_CONFIG=%LLVM_BASE_DIR%/bin/llvm-config.exe
FOR /F "tokens=* USEBACKQ" %%F IN (`%LLVM_CONFIG% --cxxflags`) DO (
SET LLVM_CXX_FLAGS=%%F
)
FOR /F "tokens=* USEBACKQ" %%F IN (`%LLVM_CONFIG% --ldflags --libs`) DO (
SET LLVM_LD_FLAGS=%%F
)
SET BAT_FILE_DIR=%~dp0
SET CRYSTAL_DIR=%BAT_FILE_DIR%\..\
SET CRYSTAL_PATH=%CRYSTAL_DIR%\src
ECHO CRYSTAL_PATH: %CRYSTAL_PATH%
cd %CRYSTAL_DIR%
nmake %* /F %BAT_FILE_DIR%\Makefile.nmake
if ERRORLEVEL 1 (
	ECHO Check that you compile required libraries LibPCRE and bdwgc!	
	ECHO See https://github.com/crystal-lang/crystal/wiki/Porting-to-Windows for details.
	ECHO Put them to LIB search path or to current directory.
)
ENDLOCAL