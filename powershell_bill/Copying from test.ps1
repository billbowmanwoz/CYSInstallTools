Write-Host "Setting Locale Variables for Installation"
$currentUserPath = Resolve-Path ~
$desktopPath = [Environment]::GetFolderPath('Desktop')
$installFolder = "$desktopPath\CYS-Installer"
$OVAfolder = "$installFolder\OVAs"
Write-Host "Making sure certain locations exist"
$doesWingetExist = Test-Path -Path "$currentUserPath\AppData\Local\Microsoft\WindowsApps\winget.exe"
$doesInstallerFolderExist = Test-Path -Path "$installFolder"
$doesOVAFolderExist = Test-Path -Path "$OVAfolder"

Write-Host "Setting download location to $desktopPath\CS-Installers"
if(-not $doesInstallerFolderExist){
    New-Item -ItemType Directory -Path "$installFolder"
}     
Set-Location -Path "$installFolder"


Write-Host "Checking to see if software is alreay installed."
if ($doesWingetExist) {
    Write-Host "Winget is already installed"
} else {
        Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.21.4/64/wget.exe" -Outfile wget.exe
        Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -UseBasicParsing -OutFile "$installFolder\Microsoft.VCLibs.x64.14.00.Desktop.appx"
        Add-AppxPackage "$installFolder\Microsoft.VCLibs.x64.14.00.Desktop.appx"
        Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "$installFolder\WinGet.msixbundle"
        Add-AppxPackage "$installFolder\WinGet.msixbundle"
        Write-Host "You will need to close Powershell and re-run the original script to continue with this Installer."
        Pause "Press ENTER to end"
        Exit
    }

Write-Host "Installing applications for the discerning CYS Student"
Write-Host "Starting with communication apps"
Write-Host "Installing Zoom"
winget install zoom.zoom 
# Write-Host "Installing slack"
# winget install --verbose  slack
# Write-Host "Now Apps for courses"
# Write-Host "Installing wget"
# winget install --verbose wget
# Write-Host "Installing Wireshark"
# winget install --verbose  wireshark
# winget install --verbose  winpcap
# Write-Host "Installing Virtualbox"
# winget install --verbose  VirtualBox
# Write-Host "Installing Visual Studio Code w/ Python"
# winget install --verbose  vscode
# winget install --verbose  python3
# winget install --verbose  nmap

Write-Host "Setting download location to $OVAfolder"
if(-not $doesOVAFolderExist){
    New-Item -ItemType Directory -Path "$OVAfolder"
}     
Set-Location -Path "$OVAfolder"

..\wget --no-hsts --no-check-cert -N https://dl.dropbox.com/s/t8rqyornhedwt4e/kali-2023.ova
..\wget --no-hsts --no-check-cert -N https://www.dropbox.com/s/zlk19cq2ued2ki3/kali-2023-sha.txt

Pause

