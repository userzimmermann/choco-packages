@echo off
REM Chocolatey MSYS2
REM
REM Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
REM
REM Licensed under the Apache License, Version 2.0

if "%~1" == "/?" (
    echo Activates an MSYS2 environment inside a CMD shell,
    echo either in MSYS or MINGW32 or MINGW64 mode,
    echo by prepending the relevant MSYS2 bin\ paths to %%PATH%%.
    echo.
    echo MSYSTEM [MSYS ^| MINGW32 ^| MINGW64]
    echo.
    echo The MINGW modes do NOT include the MSYS mode bin\ paths.
    echo.
    echo The root directory of the MSYS2 installation
    echo ^(usually C:\path\to\msys32 or ...\msys64^)
    echo must be defined in %%MSYS2_ROOT%% or must be in %%PATH%%.
    echo.
    echo After successful activation,
    echo the environment name will be stored in %%MSYS2_SYSTEM%%
    echo and an according ^<MSYS^> or ^<MINGW32^> or ^<MINGW64^> tag
    echo will be prepended to %%PROMPT%%.
    echo.
    echo Call MSYSTEM without an argument
    echo to show the currently active MSYS2 environment.
    echo.
    echo Call MSYSTEM /D to deactivate an MSYS2 environment.
    echo.
    echo Be careful when using MSYSTEM together with other shell environments
    echo ^(like virtual Python environments, etc...^).
    echo Due to %%PATH%% changes,
    echo the precedence of commands with same names also changes.
    echo Future versions of MSYSTEM will try to automatically avoid conflicts
    echo with certain other environment types.
    exit /b 0
)
if "%~1" == "" (
    REM only show info and exit
    if "%MSYS2_SYSTEM%" == "" (
        echo No active MSYS2 environment.
        exit /b 1
    )
    echo %MSYS2_SYSTEM%
    exit /b 0
)
if /i "%~1" == "/D" (
    REM deactivate MSYS2 environment
    set MSYS2_SYSTEM=
    goto prepare
)

REM Check for valid MSYS2 environment name and set %MSYS2_SYSTEM% accordingly
for %%M in (MSYS MINGW32 MINGW64) do if /i "%~1" == "%%M" (
    set MSYS2_SYSTEM=%%M
    goto prepare
)
echo Invalid argument '%~1'. Call MSYSTEM /? for help.
exit /b 1

REM check system and create variables for MSYS2 (de)activation
:prepare

if "%MSYS2_ROOT%" == "" (
    REM try to find MSYS2 root directory in %PATH%
    for %%S in (msys2_shell.bat) do (
        set "MSYS2_ROOT=%%~dp$PATH:S"
        REM %MSYS2_ROOT% would not be set in current context w/o goto
        REM (that often discussed strange set-in-for-loop behavior...)
        goto checkRoot
    )
    :checkRoot
    if "%MSYS2_ROOT%" == "" (
        echo Can't determine MSYS2 root directory.
        echo No %%MSYS2_ROOT%% defined and not in %%PATH%%.
        set MSYS2_SYSTEM=
        exit /b 1
    )
    REM remove trailing \
    set "MSYS2_ROOT=%MSYS2_ROOT:~0,-1%"
)
if not exist "%MSYS2_ROOT%\" (
    echo %%MSYS2_ROOT%% '%MSYS2_ROOT%' does not exist or is not a directory.
    set MSYS2_SYSTEM=
    exit /b 1
)

REM construct MSYS2 and MINGW32/64 bin paths
set "MSYS2_PATH=%MSYS2_ROOT%\usr\local\bin;%MSYS2_ROOT%\usr\bin;%MSYS2_ROOT%\bin"
set "MSYS2_MINGW32_PATH=%MSYS2_ROOT%\mingw32\bin"
set "MSYS2_MINGW64_PATH=%MSYS2_ROOT%\mingw64\bin"

REM always deactivate current MSYS2 environment before activating a new one
:deactivate

REM remove any existing MSYS2 and MINGW32/64 bin paths from %PATH%
call set "PATH=%%PATH:%MSYS2_PATH%;=%%"
call set "PATH=%%PATH:%MSYS2_MINGW32_PATH%;=%%"
call set "PATH=%%PATH:%MSYS2_MINGW64_PATH%;=%%"

REM remove any <MSYS> or <MINGW32/64> tags from %PROMPT%
REM (use temporary %_msysPrompt% to avoid too many %PROMPT% changes,
REM  which can result in strange shell behavior)
set _cleanPrompt=%PROMPT:$LMSYS$G$S=%
set _cleanPrompt=%_cleanPrompt:$LMINGW32$G$S=%
set _cleanPrompt=%_cleanPrompt:$LMINGW64$G$S=%

REM check if only deactivation requested (via MSYSTEM /D)
if "%MSYS2_SYSTEM%" == "" (
    prompt %_cleanPrompt%
    set _cleanPrompt=
    exit /b 0
)

:activate

REM prepend MSYS2 bin paths and/or MINGW32/64 bin paths to %PATH%
if "%MSYS2_SYSTEM%" == "MSYS" (
    set "PATH=%MSYS2_PATH%;%PATH%"
)
if "%MSYS2_SYSTEM%" == "MINGW32" (
    set "PATH=%MSYS2_MINGW32_PATH%;%PATH%"
)
if "%MSYS2_SYSTEM%" == "MINGW64" (
    set "PATH=%MSYS2_MINGW64_PATH%;%PATH%"
)

REM prepend the appropriate <MSYS> or <MINGW32/64> tag to %PROMPT%
prompt $L%MSYS2_SYSTEM%$G$S%_cleanPrompt%
set _cleanPrompt=

exit /b 0
