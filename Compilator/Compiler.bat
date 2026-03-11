@Echo off
mode con cols=80 lines=45
title Compiler Interface.u
color 0e
:m1
Echo.
Echo          ---------------------
Echo           Choose a Chronicle:
Echo          ---------------------
Echo.
Echo            1 - Interlude
Echo            2 - EXIT
Echo.
Set /p choice="Input your choice: "


REM Interlude
if "%choice%"=="1" (
cd "%~dp0/Interlude/System/"
del /F Interface_old.u 
ren Interface.u Interface_old.u
echo N|ucc make -NoBind
)
REM EXIT
if "%choice%"=="2" (
exit
)

Echo.
REM If the file exists
if exist "interface.u"  (echo *!* The compilation was successful *!*  & echo. & XCOPY "interface.u" "Build" /H /Y /Q /F & start "" "Build") else ( echo  You made a mistake, see above )

goto m1

pause >nul
