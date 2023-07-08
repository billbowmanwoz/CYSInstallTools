$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Install Visual C++ Redistributable
$vcredistInstaller = Join-Path $toolsDir 'vcredist140\VC_redist.x64.exe'
$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $toolsDir
    fileType      = 'exe'
    file          = $vcredistInstaller
    silentArgs    = '/install /quiet /norestart'
    validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

# Install VirtualBox
$virtualBoxInstaller = Join-Path $toolsDir 'VirtualBox\VirtualBox-7.0.8-156879-Win.exe'
$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $toolsDir
    fileType      = 'exe'
    file          = $virtualBoxInstaller
    validExitCodes= @(0)
    silentArgs    = '/silent'
}

Install-ChocolateyInstallPackage @packageArgs

# Install VS Code
$vsCodeInstaller = Join-Path $toolsDir 'VSCode\VSCodeUserSetup-x64-1.80.0.exe'
$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $toolsDir
    fileType      = 'exe'
    file          = $vsCodeInstaller
    validExitCodes= @(0)
    silentArgs    = '/verysilent'
}

Install-ChocolateyInstallPackage @packageArgs

# Reboot the computer
shutdown.exe /r