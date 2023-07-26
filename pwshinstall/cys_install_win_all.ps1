function get_required_files {
    Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.21.4/64/wget.exe" -UseBasicParsing -Outfile wget.exe
    .\wget --no-hsts --no-check-cert -N "https://aka.ms/vs/17/release/vc_redist.x64.exe"
    Start-Process -FilePath ".\vc_redist.x64.exe" -Wait
    .\wget --no-hsts --no-check-cert -N "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Add-AppxPackage "$installFolder\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    .\wget --no-hsts --no-check-cert -N "https://github.com/billbowmanwoz/CYSInstallTools/raw/main/pwshinstall/cys_install_win_all.ps1" -O "$desktopPath\cys_install_win_all.ps1"
}
function UACPause {
    Write-Host -ForegroundColor Red "`n`n`n`n`n`nOnce You Press ENTER, please watch for the UAC Shield Prompt to continue installations. This will happen for some of the installs, it will appear as if the installation has stopped.`n"
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
}
function hashCheck {
    $storedHash = Get-Content -Path $hashStored
    Write-Host "Checking Hash Value of $fileToCheck using $hashStored file"
    $calculatedHash = Get-FileHash -Algorithm SHA256 -Path $fileToCheck
    if ($calculatedHash.Hash -eq $storedHash) {
        Write-Host "Hash values match. File integrity verified."
    } else {
        Write-Host "Hash values do not match. File may have been altered."
        Write-Host -ForegroundColor Black -BackgroundColor White "$fileToCheck does not pass hash check. You will need to re-download"
    }}

#Beginning of Script
Clear-Host
UACPause
Write-Host -ForegroundColor Yellow "Setting Location Variables for Installation`n"
$currentUserPath = Resolve-Path ~
$desktopPath = [Environment]::GetFolderPath('Desktop')
$installFolder = "$desktopPath\CYS-Installer"
$OVAfolder = "$installFolder\OVAs"
$ISOfolder = "$installFolder\ISOs"
$pfLocation = $Env:ProgramFiles

Write-Host -ForegroundColor Yellow "Making sure certain locations exist`n"
$doesWingetExist = Test-Path -Path "$currentUserPath\AppData\Local\Microsoft\WindowsApps\winget.exe"
$doesWgetExist = Test-Path -Path "$installFolder\wget.exe"
$doesInstallerFolderExist = Test-Path -Path "$installFolder"
$doesOVAFolderExist = Test-Path -Path "$OVAfolder"
$doesISOFolderExist = Test-Path -Path "$ISOfolder"

$appsWinget = @("zoom.zoom",
                "SlackTechnologies.Slack",
                "WiresharkFoundation.Wireshark",
                "Oracle.VirtualBox",
                "Microsoft.VisualStudioCode",
                "python3",
                "Google.Chrome")


Write-Host -ForegroundColor Yellow "Setting download location to $installFolder`n"
if(-not $doesInstallerFolderExist){
    New-Item -ItemType Directory -Path "$installFolder"
}     
Set-Location -Path "$installFolder"
 
Write-Host -ForegroundColor Yellow "Checking to see if software is already installed.`n"
if (-not $doesWgetExist) {
    if(-not $doesWingetExist) {
        Write-Host -ForegroundColor Yellow "Winget and Support Files Not installed - Installing`n"
        get_required_files
        .\wget --no-hsts --no-check-cert -N "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -O "WinGet.msixbundle"
        Add-AppxPackage "$installFolder\WinGet.msixbundle"
        Write-Host -ForegroundColor Red "You will need to close Powershell and re-run the original script to continue with this Installer."
        Pause
        Exit
        }
    get_required_files
} else {
    Write-Host -ForegroundColor White "Continuing installation, all base required files are installed."
}
Write-Host -ForegroundColor Yellow "Checking for already installed CYS apps"
Write-Host -ForegroundColor Red "Please answer a 'y' to the question asked next"
winget list winget
$appsWingetInstall = New-Object System.Collections.ArrayList
$appsWingetUpgrade = New-Object System.Collections.ArrayList 
foreach ($app in $appsWinget){
    Write-Host "Checking for $app"
    $doesAppExist = winget list $app
    $match = [regex]::Match($doesAppExist, "No installed package found")
    if ($match.Success) {
        Write-Host -ForegroundColor Red "$app not found, adding to install list"
        $appsWingetInstall += "$app"
    } else {
        Write-Host -ForegroundColor Green "$app found, adding to possible upgrade"
        $appsWingetUpgrade += "$app"
    }
}

Write-Host -ForegroundColor Yellow "Installing applications for the discerning CYS Student`n"
foreach ($app in $appsWingetInstall){
    winget install $app
}
Write-Host -ForegroundColor Yellow "Installing apps that need special handling`n"

.\wget --no-hsts --no-check-cert -N "https://nmap.org/dist/nmap-7.94-setup.exe"
.\wget --no-hsts --no-check-cert -N "https://download.virtualbox.org/virtualbox/7.0.8/Oracle_VM_VirtualBox_Extension_Pack-7.0.8.vbox-extpack"

Write-Host -ForegroundColor Yellow "On the next screen, Virtualbox will be installing the Extension Pack, to continue, please answer 'Y' to the license terms."
& $pfLocation\Oracle\VirtualBox\VBoxManage.exe extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.8.vbox-extpack
Write-Host -ForegroundColor Yellow "Next a Network will be created, in case it was not during install"
& $pfLocation\Oracle\VirtualBox\VBoxManage natnetwork add --netname NATNetwork --network "10.0.2.0/24" --dhcp on


Write-Host -ForegroundColor Yellow "Setting download location to $OVAfolder"
if(-not $doesOVAFolderExist){
    New-Item -ItemType Directory -Path "$OVAfolder"
}
Set-Location -Path "$OVAfolder"

..\wget --no-hsts --no-check-cert -N https://dl.dropboxusercontent.com/s/t8rqyornhedwt4e/kali-2023.ova -O kali-2023.ova
..\wget --no-hsts --no-check-cert -N https://dl.dropboxusercontent.com/s/zlk19cq2ued2ki3/kali-2023-sha.txt -O kali-2023-sha.txt
..\wget --no-hsts --no-check-cert -N https://dl.dropboxusercontent.com/scl/fi/rj3aqa15mglb3v3r4byzu/pfSense-Router.ova?rlkey=qprrxsgwlorkxcxj96ars8dmo -O pfSense-Router.ova
..\wget --no-hsts --no-check-cert -N https://dl.dropboxusercontent.com/scl/fi/9rlqa83hqlq5bftjioeo2/pfSense-Router.ova.sha?rlkey=i58ioubob5srkiscgvubymue3 -O pfSense-Router.ova.sha

Write-Host -ForegroundColor Yellow "Setting download location to $ISOfolder"

if(-not $doesISOFolderExist){
    New-Item -ItemType Directory -Path "$ISOfolder"
}
Set-Location -Path "$ISOfolder"
..\wget --no-hsts --no-check-cert -N https://dl.dropbox.com/s/wo5lkj6ps7avz40/ubuntu-22.04.1-live-server-amd64.iso -O ubuntu-22.04.1-live-server-amd64.iso
..\wget --no-hsts --no-check-cert -N https://dl.dropbox.com/scl/fi/snx6yh5a9phz30gwrv86a/ubuntu-22.04.1-live-server-amd64.iso.sha?rlkey=648qz1xpiw265athy7ghor2w4 -O ubuntu-22.04.1-live-server-amd64.iso.sha

$ovaFileNames = @("kali-2023.ova",
                "pfSense-Router.ova")
$hashFilenames = @("kali-2023-sha.txt",
                "pfSense-router.ova.sha")

$length = $ovaFileNames.Length

for ($i = 0; $i -lt $length; $i++) {
        $hashStored = $hashFilenames[$i]
        $fileToCheck = $ovaFileNames[$i]
        hashCheck
}
Write-Host -ForegroundColor Green "Installation process has completed. Please look back to see if any of the applications did not install, if they did not, please check with a mentor to see if there is any reason that it did not."
Pause