@echo off

REM ----- Important Paths ------

set BASEPATH=Z:\deployment\Windows\Autodeploy
set CSV=models.csv
set WIM=current.wim
set DRIVERS=drivers
set SCRIPTS=scripts
set IMAGES=images
set MACSCRIPT=macimage.bat

REM ----------------------------

for /f "tokens=2 delims==" %%a in ('wmic computersystem get manufacturer /format:list') do set MANUF=%%a
set MANUF=%MANUF:  =%
call :Trim MANUF %MANUF%


for /f "tokens=2 delims==" %%a in ('wmic computersystem get model /format:list') do set SYSMODEL=%%a
set SYSMODEL=%SYSMODEL:  =%
call :Trim SYSMODEL %SYSMODEL%
echo %MANUF% %SYSMODEL%

if "%MANUF%"=="Apple Inc." %SCRIPTS%\\%MACSCRIPT%

set DRIVERPACK=nope

for /f "usebackq tokens=1-3 delims=," %%a in (%BASEPATH%\%CSV%) do (
	if "%SYSMODEL%"=="%%a" set DRIVERPACK=%%b & set WINVER=%%c & goto loopend
)
:loopend

call :Trim DRIVERPACK %DRIVERPACK%
call :Trim WINVER %WINVER%


if "%DRIVERPACK%"=="nope" (
	echo Sorry, your model isn't supported.
) ELSE (
	diskpart /s %BASEPATH%\\%SCRIPTS%\diskpart.txt
	dism /Apply-Image /ImageFile:"%BASEPATH%\winver\%WINVER%\%IMAGES%\%WIM%" /Index:1 /ApplyDir:C:\
	dism /image:C:\ /Add-Driver /driver:%BASEPATH%\winver\\%WINVER%\\%DRIVERS%\\%DRIVERPACK% /recurse
	if exist C:\Users\Default\Desktop\sysprep.cmd del /f /q C:\Users\Default\Desktop\sysprep.cmd
	copy /y %BASEPATH%\winver\%WINVER%\%IMAGES%\unattend.xml c:\Windows\Panther
	wpeutil reboot
)
exit /b

:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b
