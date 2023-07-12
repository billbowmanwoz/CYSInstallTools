Write-Host "Checking to see if software is alreay installed."

Write-Host "Installing applications for the discerning CYS Student"
Write-Host "Starting with communication apps"
Write-Host "Installing Zoom"
winget install zoom --verbose
Write-Host "Installing slack"
winget install slack
Write-Host "Now Apps for courses"
Write-Host "Installing wget"
winget install wget --verbose
Write-Host "Installing Wireshark"
winget install wireshark
Write-Host "Installing Virtualbox"
winget install VirtualBox
Write-Host "Installing Visual Studio Code w/ Python"
winget install vscode
winget install python3




#Start-Process -FilePath 'cmd.exe' -ArgumentList '/c "wget --no-check-cert https://dl.dropbox.com/s/t8rqyornhedwt4e/kali-2023.ova" '
#Start-Process -FilePath 'cmd.exe' -ArgumentList '/c "wget --no-check-cert https://www.dropbox.com/s/zlk19cq2ued2ki3/kali-2023-sha.txt" '