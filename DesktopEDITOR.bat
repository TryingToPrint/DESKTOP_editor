@echo off
title Desktop
chcp 65001 >nul
setlocal enabledelayedexpansion
mode 74, 30
cd /d "%USERPROFILE%\Desktop"
:desktop
cls
call :banner
echo [93m 			CREATE[0m
echo.
echo [33m 		[1] Create folder[0m
echo [92m 		[2] Files [0m
echo [94m 		[3] CD - Change Directory[0m
echo [34m 		[4] DIR - directory[0m
echo [95m		[5] Start program[0m
echo [31m 		[6] Change to Delete mode[0m
choice /c 123456 /n 
if %errorlevel% == 1 goto fold
if %errorlevel% == 2 goto file
if %errorlevel% == 3 goto cde
if %errorlevel% == 4 goto ref
if %errorlevel% == 5 goto str
if %errorlevel% == 6 goto del

:fold
cls
call :banner
echo [90m 		TIP - type cancel to cancel [0m
echo.
set /p fold="  Input the folder name >>  "
if "%fold%"=="cancel" (goto desktop)
else
	mkdir %fold%
goto desktop
rem FILE PLACE
:file
cls
call :banner
echo [93m 			FILE MENU[0m
echo.
echo [92m		[1] Create file[0m
echo [33m		[2] Rename file[0m
echo [36m		[3] Rename all files[0m
echo.
echo.
echo [91m		[4][0m Back
choice /c 1234 /n
if %errorlevel% == 1 goto fc
if %errorlevel% == 2 goto fr
if %errorlevel% == 3 goto far
if %errorlevel% == 4 goto desktop

:fc
cls
call :banner
set /p file="Input file name >>  "
if "%file%"=="cancel" (goto file)
type nul > %file%
goto desktop

:fr
cls
call :banner
set /p ofile="Input file name >>  "
if "%ofile%"=="cancel" (goto file)
cls
call :banner
set /p nfile="Input new file name >>  "
if "%nfile%"=="cancel" (goto file)
ren %ofile% %nfile%
cls
call :banner
echo [34m		[*][0m Executing changes...
timeout /t 2 >nul
goto desktop

:far
cls
call :banner
set /p oe="Enter extension to be changed >  "
set /p ne="Enter new extension >  "

:: Iterate through files with the old extension
for %%F in (*.%oe%) do (
    set "oldName=%%~nF"
    set "newName=!oldName!.!ne!"

    if not "%%F"=="!newName!" (
        set "tempName=!newName!"
        ren "%%F" "!tempName!" > nul
        move "!tempName!" "!newName!" > nul
    )
)
goto desktop

rem END FILE PLACE

:cde 
cls
call :banner
echo [90m 		TIP - ".." makes you go jump back a dir [0m
echo.
set /p cde=" Place you want to go >   "
if "%cde%"=="home" (
	echo where is home?
	timeout /t 2 > nul
	cls 
	call :banner
	echo HOME
	timeout /t 2 > nul
	cls 
	call :banner
	echo A PLACE WHERE I CAN GO 
	timeout /t 2 > nul
	cls 
	call :banner
	echo jk lol
	timeout /t 1 > nul
	cls
	call :banner
)
cd "%cde%"
timeout /t 1 > nul
goto desktop

:ref
cls
dir
pause
goto desktop

:str
cls 
call :banner
echo Program to start :
set /p dsrt=">>     "
if "%dsrt%"=="cancel" (goto desktop)
start %dsrt%
timeout /t 1 > nul
goto desktop

:del
cls
call :banner
echo [31m 			DELETE[0m
echo.
echo [33m 		[1] Delete file[0m
echo [92m 		[2] Delete file[0m
echo [94m 		[3] CD - Change Directory[0m
echo [34m 		[4] DIR - directory[0m
echo [95m		[5] Stop program[0m
echo [93m 		[6] Change to Create mode[0m
choice /c 123456 /n 
if %errorlevel% == 1 goto dele
if %errorlevel% == 2 goto dele
if %errorlevel% == 3 goto cdd
if %errorlevel% == 4 goto dir
if %errorlevel% == 5 goto dtr
if %errorlevel% == 6 goto desktop

:dele
cls
call :banner
echo.
echo Input the name of the file to delete 
set /p dera=" >>    "
if "%dera%"=="cancel" (goto del)
echo [31m	Do you wish to contiue? -Y/N-[0m
choice /c yn /n
if errorlevel == 2 goto del
:contin
rmdir /s /q %dera%
del %dera%

cls
call :banner
echo [31m 		[*][0m Deleting...
timeout /t 3 > nul
goto del


:cdd 
cls
call :banner
set /p cdd=" Place you want to go >   "
if "%nfile%"=="cancel" (goto del)
cd "%cdd%"
timeout /t 1 > nul
goto del
:dir
cls
dir
pause
goto del

:dtr
cls 
call :banner
echo Program to stop :
set /p drt=">>     "
if "%drt%"=="cancel" (goto file)
taskkill /F /IM %drt%
timeout /t 1 > nul
goto del
rem Credits to @TryingToPrint / Mihai

:banner
echo.
echo.
echo [36m	██████╗ ███████╗███████╗██╗  ██╗████████╗ ██████╗ ██████╗ [0m
echo [36m	██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██╔═══██╗██╔══██╗[0m
echo [94m	██║  ██║█████╗  ███████╗█████╔╝    ██║   ██║   ██║██████╔╝[0m
echo [94m	██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██║   ██║██╔═══╝ [0m
echo [34m	██████╔╝███████╗███████║██║  ██╗   ██║   ╚██████╔╝██║     [0m
echo [34m	╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝     [0m
echo.
echo.
echo [90m    Current directory : %CD%[0m
echo.
echo.