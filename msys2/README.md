Chocolatey MSYS2
================

MSYS2 is an independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software.

You should read the full official [introduction](http://sourceforge.net/p/msys2/wiki/MSYS2%20introduction/) before using MSYS2.

### NOTES

Chocolatey MSYS2 downloads and extracts the official MSYS2 binary archives to `%ChocolateyBinRoot%` (usually **C:\\Tools\\**). The 32bit variants contain an **msys32\\** root folder and the 64bit variants contain **msys64\\** respectively. This MSYS2 root folder will be appended to `%PATH%`. It contains the **msys2_shell.bat**, **mingw32_shell.bat**, and **mingw64_shell.bat** scripts. No **bin\\** folders will be added to `%PATH%`.

Chocolatey MSYS2 contains an extra **msystem.bat** script, which can be used to activate and switch `MSYS`, `MINGW32`, and `MINGW64` environments inside a CMD shell without running Bash. It will prepend the appropriate **bin\\** folders to `%PATH%`. Call `msystem /?` after installation or look at the script file below for details. More extra features and an according PowerShell module will be added in future releases of Chocolatey MSYS2.
