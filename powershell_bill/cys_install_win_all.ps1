Write-Host -ForegroundColor Yellow "Setting Locale Variables for Installation"
$currentUserPath = Resolve-Path ~
$desktopPath = [Environment]::GetFolderPath('Desktop')
$installFolder = "$desktopPath\CYS-Installer"
$OVAfolder = "$installFolder\OVAs"
Write-Host -ForegroundColor Yellow "Making sure certain locations exist"
$doesWingetExist = Test-Path -Path "$currentUserPath\AppData\Local\Microsoft\WindowsApps\winget.exe"
$doesInstallerFolderExist = Test-Path -Path "$installFolder"
$doesOVAFolderExist = Test-Path -Path "$OVAfolder"

$appsWinget = @("zoom.zoom",
                "SlackTechnologies.Slack",
                "WiresharkFoundation.Wireshark",
                "Oracle.VirtualBox",
                "Microsoft.VisualStudioCode",
                "python3",
                "Google.Chrome")

Write-Host -ForegroundColor Yellow "Setting download location to $desktopPath\CS-Installers"
if(-not $doesInstallerFolderExist){
    New-Item -ItemType Directory -Path "$installFolder"
}     
Set-Location -Path "$installFolder"

Write-Host -ForegroundColor Yellow "Checking to see if software is alreay installed."
if ($doesWingetExist) {
    Write-Host -ForegroundColor Yellow "Winget is already installed"
} else {
    Write-Host -ForegroundColor Yellow "Winget and Supporting Files Not installed - Installing"
    Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.21.4/64/wget.exe" -Outfile wget.exe
    .\wget --no-hsts --no-check-cert -N "https://aka.ms/vs/17/release/vc_redist.x64.exe"
    Pause -ForegroundColor Red "About to Begin Visual C++ Redistributable Installation, Watch for the UAC prompt after pressing the ENTER key and allow the install"
    Start-Process -FilePath ".\vc_redist.x64.exe" -ArgumentList "/quiet" -Wait
    Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -UseBasicParsing -OutFile "$installFolder\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Add-AppxPackage "$installFolder\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "$installFolder\WinGet.msixbundle"
    Add-AppxPackage "$installFolder\WinGet.msixbundle"

    Write-Host -ForegroundColor Yellow "You will need to close Powershell and re-run the original script to continue with this Installer."
    Pause "Press ENTER to end"
    Exit
    }

Write-Host -ForegroundColor Yellow "Installing applications for the discerning CYS Student"
foreach ($app in $appsWinget){
    winget install $app
}

winget install winpcap
.\wget "https://nmap.org/dist/nmap-7.94-setup.exe"
#winget install Insecure.Nmap

Write-Host -ForegroundColor Yellow "Setting download location to $OVAfolder"
if(-not $doesOVAFolderExist){
    New-Item -ItemType Directory -Path "$OVAfolder"
}     
Set-Location -Path "$OVAfolder"

..\wget --no-hsts --no-check-cert -N https://dl.dropbox.com/s/t8rqyornhedwt4e/kali-2023.ova
..\wget --no-hsts --no-check-cert -N https://www.dropbox.com/s/zlk19cq2ued2ki3/kali-2023-sha.txt

Pause