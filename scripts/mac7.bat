@echo off

REM ----- Important Paths ------

set WIM="Z:\WIM Imaging\images\win7.wim"
set DRIVERS="Z:\WIM Imaging\mac\drivers"
set WIFI="Z:\WIM Imaging\drivers\wifi"
set UNATTEND="Z:\WIM Imaging\mac\unattend"
set FORMAT="Z:\WIM Imaging\mac\format.txt"

REM ----------------------------

type %FORMAT% | format c: /q /fs:ntfs /v:BOOTCAMP
dism /Apply-Image /ImageFile:%WIM% /Index:1 /ApplyDir:C:\
dism /Image:C:\ /Add-Driver /Driver:%DRIVERS% /Recurse
if exist C:\Users\Default\Desktop\sysprep.cmd del /f /q C:\Users\Default\Desktop\sysprep.cmd
copy /y %WIFI%\*.* c:\Users\Public\Desktop
mkdir c:\Windows\Setup\Scripts
copy /y %UNATTEND%\setupcomplete.cmd c:\Windows\Setup\Scripts
copy /y %UNATTEND%\unattend.xml c:\Windows\Panther
copy /y %UNATTEND%\brigadier.exe c:\Windows
REM wpeutil reboot