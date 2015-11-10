@echo off
REM Chocolatey OpenDaylight Lithium
REM
REM Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
REM
REM Licensed under the Apache License, Version 2.0

setlocal EnableDelayedExpansion

REM read Lithium distribution installation folder from .\KARAF_HOME
REM which is created during Chocolatey package installation
for /f "usebackq" %%D in ("%~dp0\KARAF_HOME") do (
    set "KARAF_HOME=%%D"
    goto :parseArgs
)

:parseArgs

REM used as CMD window title by karaf.bat
set KARAF_TITLE=Lithium-SR2

if "%~1" == "/?" (
    echo Runs OpenDaylight Lithium-SR2 management commands via
    echo '%KARAF_HOME%\bin\karaf.bat'
    echo.
    echo LITHIUM [command] [args [ ...]]
    echo.
    echo Available commands are:
    echo.
    echo     clean
    echo     client
    echo     console
    echo     debug
    echo     server
    echo     start
    echo     status
    echo     stop
    echo.
    echo If no command is given then 'console' is called implicitly,
    echo which is actually the same as running 'karaf.bat'
    echo without an argument.
    echo.
    echo The 'start' command actually calls the 'server' command,
    echo but in a new CMD window, similar to how it is done by the dedicated
    echo '%KARAF_HOME%\bin\start.bat'.
    echo But unlike the latter it does not create the CMD window minimized.
    echo So it appears as a new tab in console managers like ConEmu.
    echo.
    echo The 'client' command calls the dedicated
    echo '%KARAF_HOME%\bin\client.bat'
    echo instead of 'karaf.bat client'.
    echo.
    echo %%KARAF_HOME%% is set to '%KARAF_HOME%'
    echo and %%KARAF_TITLE%% is set to '%KARAF_TITLE%'
    echo before running 'karaf.bat' or 'client.bat'.
    exit /b 0
)

if "%~1" == "" (
    REM implicitly run karaf.bat console command
    set cmd=console
) else (
    set "cmd=%~1"
)

if "%cmd%" == "start" (
    REM open a new CMD window for the server process
    start "%KARAF_TITLE%" "%KARAF_HOME%\bin\karaf.bat" server
    exit /b
)

if "%cmd%" == "client" (
    REM run dedicated client.bat instead of karaf.bat
    REM (run through new CMD instance to get window title reset afterwards)
    cmd /c "%KARAF_HOME%\bin\client.bat" %~2 %~3 %~4 %~5
    exit /b
)

REM run through new CMD instance to get window title reset afterwards
cmd /c "%KARAF_HOME%\bin\karaf.bat" %cmd%

endlocal
