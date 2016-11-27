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

**Chocolatey MSYS2** is not affiliated with the MSYS2 project and does not include a copy of MSYS2. It just automatically downloads and installs MSYS2.

### NOTES

Chocolatey MSYS2 is now a meta-package depending on MSYS2.portable, which installs the zipped MSYS2 archive to Chocolatey's **ToolsLocation** (usually **C:\Tools\**). If you prefer the MSYS2 installer, you should choose the MSYS2.install package instead.
