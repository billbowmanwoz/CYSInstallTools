# CYSInstallTools

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/billbowmanwoz/CYSInstallTools/raw/main/powershell_bill/cys_install_win_all.ps1'))

Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Url https://github.com/billbowmanwoz/CYSInstallTools/raw/main/powershell_bill/cys_install_win_all.ps1 -Outfile .\cys_install.ps1

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/billbowmanwoz/CYSInstallTools/raw/main/pwshinstall/cys_install_win_all.ps1'))
