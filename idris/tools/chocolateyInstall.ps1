$ErrorActionPreference = 'Stop';

$packageName = 'idris'

$idrisVersion = '1.3.0'

$url = "https://neon.se/idris/idris-$idrisVersion-win32.7z"
$checksum = '5BB6AFCE33987A190086CFDC59B4CDFE8E3254EC'
$checksumType = 'SHA1'

$url64 = "https://neon.se/idris/idris-$idrisVersion-win64.7z"
$checksum64 = 'C8F787C39BA34F7BEB133D9F559F06E74DA10E8F'
$checksumType64 = 'SHA1'

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Write-Host "Installing to '$toolsDir'"
Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
  -checksum $checksum -checksumType $checksumType `
  -checksum64 $checksum64 -checksumType64 $checksumType64

$idrisDir = Join-Path $toolsDir idris
$mingwDir = Join-Path $idrisDir mingw

# avoid shim creation for mingw tools
# (only idris*.exe shims shall be created)
foreach ($exe in (Get-ChildItem $mingwDir '*.exe' -Recurse)) {
    New-Item $exe.Directory -Type File -Name "$exe.ignore"
}
