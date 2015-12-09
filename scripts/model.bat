@echo off
for /f "tokens=2 delims==" %%a in ('wmic computersystem get model /format:list') do set SYSMODEL=%%a
set SYSMODEL=%SYSMODEL:  =%
call :Trim SYSMODEL %SYSMODEL%
echo %SYSMODEL%
exit /b


:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b