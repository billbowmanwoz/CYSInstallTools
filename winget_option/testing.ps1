
if (Get-ChildItem -Path Env:ChocolateyInstall) {
choco upgrade chocolatey
}
else {
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

choco install winget


if (Get-ChildItem -Path Env:ChocolateyInstall) {
    choco upgrade chocolatey
    }
    else {
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
    
    choco install winget
    
    winget install wireshark
    winget install npcap
    
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://download.virtualbox.org/virtualbox/7.0.8/Oracle_VM_VirtualBox_Extension_Pack-7.0.8.vbox-extpack'))-

    pause

    $wingetInstalled = Get-Command -Name winget -ErrorAction SilentlyContinue

if ($wingetInstalled -eq $null) {
    Write-Host "Windows Package Manager (winget) is not installed. Installing..."
    
    $installerPath = "$env:TEMP\winget_installer.msi"
    $downloadUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/winget-cli-x64.msi"

    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath -UseBasicParsing
        Start-Process -Wait -FilePath msiexec -ArgumentList "/i $installerPath /qn"
        Write-Host "Windows Package Manager (winget) has been installed."
    }
    catch {
        Write-Host "Failed to download or install Windows Package Manager (winget)."
        Write-Host $_.Exception.Message
    }
}
else {
    Write-Host "Windows Package Manager (winget) is already installed."
}
