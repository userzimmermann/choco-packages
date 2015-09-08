Chocolatey MSYS2
================

MSYS2 is an independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software.

You should read the full [official introduction](http://sourceforge.net/p/msys2/wiki/MSYS2%20introduction/) before using MSYS2.

### NOTES

Chocolatey MSYS2 has its own versioning scheme. The first three numbers are the Chocolatey package version and the last number ist the MSYS2 archive version that will be downloaded.

Chocolatey MSYS2 automatically installs either 32bit or 64bit MSYS2. It does NOT work with `choco install -x86` (forced 32bit installation) under 64bit Windows. There is usually no need to install a 32bit MSYS2 under 64bit Windows, because MSYS2 always contains a MINGW32 and a MINGW64 environment.

The MSYS2 archive will be extracted to Chocolatey's **BinRoot** (usually **C:\\Tools\\**). The 32bit variant uses an **msys32\\** root folder and the 64bit variant uses **msys64\\** respectively. The MSYS2 root folder will be appended to `%PATH%`. It contains the **msys2_shell.bat**, **mingw32_shell.bat**, and **mingw64_shell.bat** scripts. No **bin\\** folders will be added to `%PATH%`. After unpacking, MSYS2 will be automatically initialized and updated with Pacman according to the [official instructions](https://msys2.github.io).

MSYS2 itself will not be removed on uninstalling the Chocolatey package and will not be downloaded and extracted again (even if the MSYS2 archive version has changed) on updating or reinstalling the Chocolatey package. The existing MSYS2 will just be updated with Pacman.

Chocolatey MSYS2 offers an extra **msystem.bat** script in its package folder (which will also be appended to `%PATH%`). The script can be used to activate and switch **MSYS**, **MINGW32**, and **MINGW64** environments inside a CMD shell without running Bash. It will prepend the appropriate **bin\\** folders to `%PATH%`. Call `msystem /?` after installation or look at the top of the script file for details. More extra features and an according PowerShell module will be added in future releases of Chocolatey MSYS2.
