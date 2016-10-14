$ErrorActionPreference = 'Stop';

$packageName = 'idris'

$idrisVersion = '0.12.3'

$url = "http://neon.se/idris/idris-$idrisVersion-win32.7z"
$checksum = '6169C98B2B47C6DD68125FE9D2AEA347A51458A2'
$checksumType = 'SHA1'

$url64 = "http://neon.se/idris/idris-$idrisVersion-win64.7z"
$checksum64 = '9D5E81EAFF61E22BF42CE67F594000CD773EB9C1'
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
