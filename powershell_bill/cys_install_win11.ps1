$currentUserPath = Resolve-Path ~
$desktopPath = [Environment]::GetFolderPath('Desktop')
$installFolder = "$desktopPath\CYS-Installer"
$OVAfolder = "$installFolder\OVAs"

$doesWingetExist = Test-Path -Path "$currentUserPath\AppData\Local\Microsoft\WindowsApps\winget.exe"
$doesInstallerFolderExist = Test-Path -Path "$installFolder"


Write-Host "Setting download location to $desktopPath\CS-Installers"
if($doesInstallerFolderExist){
    Set-Location -Path "$installFolder"
} else {
    New-Item -ItemType Directory -Path "$installFolder"
    Set-Location -Path "$installFolder"
}

Write-Host "Checking to see if software is alreay installed."
if ($doesWingetExist) {
    Write-Host "Winget is already installed"
} else {
        Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vc_redist.x64.exe" -UseBasicParsing -OutFile "$installFolder\vc_redist_x64.exe"
        Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "$installFolder\WinGet.msixbundle"
        Add-AppxPackage "$installFolder\WinGet.msixbundle"
        Write-Host "You will need to close Powershell and re-run the original script to continue with this Installer."
        Pause "Press ENTER to end"
        Exit
    }

Write-Host "Installing applications for the discerning CYS Student"
Write-Host "Starting with communication apps"
Write-Host "Installing Zoom"
winget install --verbose zoom.zoom 
Write-Host "Installing slack"
winget install --verbose  slack
Write-Host "Now Apps for courses"
Write-Host "Installing wget"
winget install --verbose wget
Write-Host "Installing Wireshark"
winget install --verbose  wireshark
winget install --verbose  winpcap
Write-Host "Installing Virtualbox"
winget install --verbose  VirtualBox
Write-Host "Installing Visual Studio Code w/ Python"
winget install --verbose  vscode
winget install --verbose  python3
winget install --verbose  nmap

New-Item -ItemType Directory -Path "$OVAfolder"
Set-Location -Path "$OVAfolder"
Start-Process -FilePath 'cmd.exe' -ArgumentList '/c "wget --no-check-cert -N https://dl.dropbox.com/s/t8rqyornhedwt4e/kali-2023.ova" ' -Wait
#Start-Process -FilePath 'cmd.exe' -ArgumentList '/c "wget --no-check-cert -N https://www.dropbox.com/s/zlk19cq2ued2ki3/kali-2023-sha.txt" ' -Wait



