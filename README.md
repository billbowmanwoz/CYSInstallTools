# CYSInstallTools

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://dl.dropboxusercontent.com/s/70gthoxuhpoqfqn/cys_install.ps1'))

Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Url https://github.com/billbowmanwoz/CYSInstallTools/raw/main/powershell_bill/cys_install.ps1 -Outfile .\cys_install.ps1
