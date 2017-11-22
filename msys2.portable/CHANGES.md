### 20160719.1.1

* Search for exact **.tar** file in install script.
* Explicitly check final unzipping result.

### 20160719.1.0

* Adapted **msystem.bat** to new MSYS2 versions.
* Fixed an install script error message.

### 20160719.0.1

* Updated 32bit and 64bit download URLs for MSYS2 20160719.
* Fixed install script for new Chocolatey and MSYS2 versions.
* Added **petemounce** to `<owners>` in **msys2.nuspec**.
* Thanks to `github.com/petemounce` and his pull requests!

### 20150916.0.1

* Updated 32bit and 64bit download URLs for MSYS2 20150916.
* Added `<packageSourceUrl>`, `<projectSourceUrl>`, and `<docsUrl>` 
  to **msys2.nuspec**

### 20150916.0.0

* Changed versioning scheme.
* Downloads 32bit or 64bit MSYS2 20150916.

### 1.1.0.20150512

* Extra **msys\bash.bat** and **msys\pacman.bat** wrappers for **MSYS** mode.
* Clink auto-completion scripts for **msystem** and **pacman**.
* `msystem /i clink` feature
  for installing Clink auto-completion script loader.

### 1.0.1.20150512

* Removed convenience **msys2.bat**, **mingw32.bat**, and **mingw64.bat**
  to avoid confusions.

### 1.0.0.20150512

* First Chocolatey MSYS2 release!
* Downloads 32bit or 64bit MSYS2 20150512.
* Contains **msystem.bat** 
  and convenience **msys2.bat**, **mingw32.bat**, and **mingw64.bat**
  for activating **MSYS**, **MINGW32**, and **MINGW64** environments
  inside a CMD shell without running Bash.
