# Chocolatey MSYS2
#
# Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
#
# Licensed under the Apache License, Version 2.0

$ErrorActionPreference = 'Stop';

$packageName = 'msys2'

$msysVersion = '20160921'

$msys32DistName = "msys2-base-i686-$msysVersion"
$msys64DistName = "msys2-base-x86_64-$msysVersion"

$url = "http://repo.msys2.org/distrib/i686/$msys32DistName.tar.xz"
$checksum = '7DA041072DC2F8A346803AFE4FF1E1977DD1E905'
$checksumType = 'SHA1'

$url64 = "http://repo.msys2.org/distrib/x86_64/$msys64DistName.tar.xz"
$checksum64 = '78B1738EB6049EFB693E3D1AA4502BCBE03B2964'
$checksumType64 = 'SHA1'

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageDir = Split-Path -parent $toolsDir
Write-Host "Adding '$packageDir' to PATH..."
Install-ChocolateyPath $packageDir

$osBitness = Get-ProcessorBits
if ($osBitness -eq 32) {
    $msysDistName = $msys32DistName
}
else {
    $msysDistName = $msys64DistName
}

$binRoot = Get-ToolsLocation
# MSYS2 zips contain a root dir named msys32 or msys64
$msysName = 'msys' + $osBitness
$msysRoot = Join-Path $binRoot $msysName

if (Test-Path $msysRoot) {
    Write-Host "'$msysRoot' already exists and will only be updated."
}
else {
    Write-Host "Installing to '$msysRoot'"
    Install-ChocolateyZipPackage $packageName $url $binRoot $url64 `
      -checksum $checksum -checksumType $checksumType `
      -checksum64 $checksum64 -checksumType64 $checksumType64

    # check if .tar.xz was only unzipped to tar file
    # (shall work better with newer choco versions)
    $tarFile = Join-Path $binRoot "$msysDistName.tar"
    if (Test-Path $tarFile) {
        Get-ChocolateyUnzip $tarFile $binRoot
        Remove-Item $tarFile
        if (-not (Test-Path $msysRoot)) {
            throw "No '$msysRoot' found after extracting."
        }
    }
    else {
        if (-not (Test-Path $msysRoot)) {
            throw "No '$tarFile' or '$msysRoot' found after unzipping."
        }
    }
}

Write-Host "Adding '$msysRoot' to PATH..."
Install-ChocolateyPath $msysRoot

# Finally initialize and upgrade MSYS2 according to https://msys2.github.io
# and https://sourceforge.net/p/msys2/wiki/MSYS2%20installation/
$msysShell = Join-Path (Join-Path (Join-Path $msysRoot usr) bin) bash.exe

# define a function for easying the execution of bash scripts.
function Bash($script) {
    $eap = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        # we also redirect the stderr to stdout because PowerShell
        # oddly interleaves them.
        # see https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin
        echo "exec 2>&1;set -eu;export PATH=`"/usr/bin:`$PATH`";$script" | &$msysShell --login
        if ($LASTEXITCODE) {
            throw "bash execution failed with exit code $LASTEXITCODE"
        }
    } finally {
        $ErrorActionPreference = $eap
    }
}

# setting TERM to an unknown terminal name prevents something in the MSYS2
# initialization from messing up the terminal (ConEmu in particular).
$env:TERM = 'none'

# do the initial initialization.
# at the first run msys2 will at least initialize pacman.
Write-Host 'Initializing MSYS2...'
Bash

# do the upgrade by running $command until no more packages are
# available (when --print no longer outputs any url).
$command = 'pacman --noconfirm --noprogressbar -Syuu'
while (Bash "$command --print" | Select-String '^https?://' -Quiet) {
    Write-Host 'Upgrading MSYS2...'
    Bash $command
}
