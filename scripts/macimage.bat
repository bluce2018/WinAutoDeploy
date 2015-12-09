@echo off

REM ----- Important Paths -----

set SCRIPTS="Z:\WIM Imaging\scripts"
set W8ONLY="Z:\WIM Imaging\macsw8only.txt"
set W8SCRIPT="mac81.bat"
set W7SCRIPT="mac7.bat"

REM ---------------------------

for /f "tokens=2 delims==" %%a in ('wmic computersystem get model /format:list') do set SYSMODEL=%%a
set SYSMODEL=%SYSMODEL:  =%
call :Trim SYSMODEL %SYSMODEL%

set W8=0
for /f %%a IN ('type %W8ONLY%') DO (
	if "%SYSMODEL%"=="%%a" set W8=1 & goto loopend
)
:loopend

if %W8%==1 (
	echo Windows 8.1
	%SCRIPTS%\\%W8SCRIPT%
) else (
	echo Windows 7
	%SCRIPTS%\\%W7SCRIPT%
)

exit /b

:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b
