# Chocolatey OpenDaylight Lithium
#
# Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
#
# Licensed under the Apache License, Version 2.0

$ErrorActionPreference = 'Stop';

$packageName = 'opendaylight'

$releaseName = '0.3.2-Lithium-SR2'
$distributionName = "distribution-karaf-$releaseName"

$url = "https://nexus.opendaylight.org/content/repositories/" `
  + "opendaylight.release/org/opendaylight/integration/distribution-karaf/" `
  + "$releaseName/$distributionName.zip"

$checksum = '123dae0dd38f4a14ae6dd49f6fdfbb82ab0588c4'
$checksumType = 'SHA1'

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageDir = Split-Path -parent $toolsDir
Write-Host "Adding '$packageDir' to PATH..."
Install-ChocolateyPath $packageDir

$binRoot = Get-BinRoot
$daylightRoot = Join-Path $binRoot OpenDaylight

Write-Host "Installing to '$daylightRoot'"
Install-ChocolateyZipPackage $packageName $url $daylightRoot `
  -checksum $checksum -checksumType $checksumType

$karafHome = Join-Path $daylightRoot $distributionName

$karafHomeFile = Join-Path $packageDir KARAF_HOME
Write-Host "Writing '$karafHome' to '$karafHomeFile'"
Out-File $karafHomeFile -InputObject $karafHome
