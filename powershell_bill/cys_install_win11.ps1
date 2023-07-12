Write-Host "Installing applications for the CYS"
Write-Host "Starting with wget"
winget install wget --verbose
Write-Host "Installing Wireshark"
winget install wireshark
Write-Host "Installing Virtualbox"
winget install VirtualBox

#Start-Process -FilePath 'cmd.exe' -ArgumentList '/c "wget --no-check-cert https://dl.dropbox.com/s/t8rqyornhedwt4e/kali-2023.ova" '
#Start-Process -FilePath 'cmd.exe' -ArgumentList '/c "wget --no-check-cert https://www.dropbox.com/s/zlk19cq2ued2ki3/kali-2023-sha.txt" '