Chocolatey Idris
=================

[![](https://img.shields.io/chocolatey/v/idris.svg)](
  https://chocolatey.org/packages/idris)
[![](https://img.shields.io/chocolatey/dt/idris.svg)](
  https://chocolatey.org/packages/idris)

[![](https://ci.appveyor.com/api/projects/status/4gxc6i7oh6ainu57?svg=true)](
  https://ci.appveyor.com/project/userzimmermann/choco-packages-85c6u)

**From** http://www.idris-lang.org :

"Idris is a general purpose pure functional programming language with dependent types. Dependent types allow types to be predicated on values, meaning that some aspects of a program's behaviour can be specified precisely in the type. It is compiled, with eager evaluation. Its features are influenced by Haskell and ML, ..."

You can find the full feature list and comprehensive documentation at the link above and the [Idris-dev Github wiki](https://github.com/idris-lang/Idris-dev/wiki).

**Chocolatey Idris** is not affiliated with the Idris project and does not include a copy of Idris. It just automatically downloads and installs the Idris [Windows binary distribution](https://github.com/idris-lang/Idris-dev/wiki/Windows-Binaries).

### INFOS

Chocolatey Idris automatically installs either the 32bit or 64bit Idris distribution.

The Idris archive will be extracted to the Chocolatey package's **tools\\** sub-directory (usually **C:\\ProgramData\\chocolatey\\lib\\idris\\tools\\**), and Chocolatey will create shims for **idris.exe** and all **idris-codegen-*.exe** files, so that they are available in `%PATH%`.

On updating or uninstalling, the (old) Idris distribution will be deleted together with the (old) Chocolatey package files.
