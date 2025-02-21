# CYSInstallTools

# Install on Windows 10  (Best if run in an Administrator Powershell Windows) 

Set-ExecutionPolicy Bypass -Scope Process; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/billbowmanwoz/CYSInstallTools/raw/main/pwshinstall/cys_install_win_10.ps1'))

# Install on Windows 11 (Best if run in an Administrator Powershell Window)

Set-ExecutionPolicy Bypass -Scope Process; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/billbowmanwoz/CYSInstallTools/raw/main/pwshinstall/cys_install_win_11.ps1'))

# Use this script to get the specs of the windows computer

Set-ExecutionPolicy Bypass -Scope Process; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/billbowmanwoz/CYSInstallTools/raw/main/testFilesFolder/getComputerSpecs.ps1'))
