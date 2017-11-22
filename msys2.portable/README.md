Chocolatey MSYS2
================

[![](https://img.shields.io/chocolatey/v/msys2.svg)](
  https://chocolatey.org/packages/msys2)
[![](https://img.shields.io/chocolatey/dt/msys2.svg)](
  https://chocolatey.org/packages/msys2)

[![](https://ci.appveyor.com/api/projects/status/wf4g2ftsatog8wvf?svg=true)](
  https://ci.appveyor.com/project/userzimmermann/choco-packages-6hb62)

> Chocolatey package licensed under the [Apache License, Version 2.0](
    http://www.apache.org/licenses/LICENSE-2.0)

**From** https://sourceforge.net/p/msys2/wiki/MSYS2%20introduction/ :

"MSYS2 is an independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software."

You should read the full [official introduction](http://sourceforge.net/p/msys2/wiki/MSYS2%20introduction/) before using MSYS2.

**Chocolatey MSYS2** is not affiliated with the MSYS2 project and does not include a copy of MSYS2. It just automatically downloads and installs MSYS2 and adds some extra tools for better integration into CMD shell (and PowerShell in future releases).

### NOTES

The Chocolatey MSYS2 versioning scheme uses the current MSYS2 archive version as first component and tracks further changes in the Chocolatey package with the second and third component.

Chocolatey MSYS2 automatically installs either 32bit or 64bit MSYS2. It does NOT work with `choco install -x86` (forced 32bit installation) under 64bit Windows. There is usually no need to install a 32bit MSYS2 under 64bit Windows, because MSYS2 always contains a MINGW32 and a MINGW64 environment.

The MSYS2 archive will be extracted to Chocolatey's **BinRoot** (usually **C:\\Tools\\**). The 32bit variant uses an **msys32\\** root folder and the 64bit variant uses **msys64\\** respectively. The MSYS2 root folder will be appended to `%PATH%`. It contains the **msys2\_shell.bat**, **mingw32\_shell.bat**, and **mingw64\_shell.bat** scripts. No **bin\\** folders will be added to `%PATH%`. After unpacking, MSYS2 will be automatically initialized and updated with Pacman according to the [official instructions](https://msys2.github.io).

MSYS2 itself will not be removed on uninstalling the Chocolatey package and will not be downloaded and extracted again (even if the MSYS2 archive version has changed) on updating or reinstalling the Chocolatey package. The existing MSYS2 will just be updated with Pacman.

Chocolatey MSYS2 offers an extra **msystem.bat** script in its package folder (which will also be appended to `%PATH%`). The script can be used to activate and switch **MSYS**, **MINGW32**, and **MINGW64** environments inside a CMD shell without running Bash. It will prepend the appropriate **bin\\** folders to `%PATH%`. **MSYS** mode additionally provides **bash.bat** and **pacman.bat** wrapper scripts and according auto-completion scripts for Clink. Call `msystem /?` after installation or look at the top of the script file for more details. These extra features and even more (like better integration with other shell environments, a better **bash.bat**, and more wrapper scripts for tools like `makepkg`, ..., and an according PowerShell module) will be moved from the Chocolatey MSYS2 package to separate projects, which will then be installable as MSYS2 packages, of course auto-installed by Chocolatey MSYS2 :)
