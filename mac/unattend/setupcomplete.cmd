wmic useraccount where name='Administrator' call rename name='itsadmin'
move c:\windows\temp\cleanup.bat "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"