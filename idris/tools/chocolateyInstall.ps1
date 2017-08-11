$ErrorActionPreference = 'Stop';

$packageName = 'idris'

$idrisVersion = '1.1.1'

$url = "https://neon.se/idris/idris-$idrisVersion-win32.7z"
$checksum = '40F5FB612C37F0E4D7F30B29F55776B3D46E9E13'
$checksumType = 'SHA1'

$url64 = "https://neon.se/idris/idris-$idrisVersion-win64.7z"
$checksum64 = 'FB73F87F09CE9881476B4DE312AA4A0E1BBC13C4'
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
