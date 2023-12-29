$test_file =  "$env:USERPROFILE\CYS_begun.txt"

if(!(Test-Path -Path $test_file)) {
    $systemInfo = systeminfo

    $osRegex = $osRegex = 'OS Name:\s+(.+)$'
    $buildRegex = '(.+N/A Build )(.+)$'
    $osName = $systemInfo | Select-String -Pattern $osRegex | ForEach-Object { $_.Matches.Groups[1].Value }
    $OSBuildNumber = $systemInfo | Select-String -Pattern $buildRegex | ForEach-Object { $_.Matches.Groups[2].Value }

    function nextSteps {
        $osVer | Out-File -FilePath $env:USERPROFILE\CYS_begun.txt
        $scriptName = "https://github.com/billbowmanwoz/CYSInstallTools/raw/main/pwshinstall/cys_install_win_$osver.ps1"
        Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('$scriptName'))" -Verb RunAs
        [Environment]::Exit(1)
        }

    if ($osName -match "Windows 11") {
        Write-Host "Windows 11"
        Pause
        $osVer = "11"
        nextSteps
    }elseif($osName -match "Windows 10") {
        If ($OSBuildNumber -lt 17134){
            Write-Host "This computer is not compatible with the applications for the Cyber Security Program"
        }else {
            Write-Host "Windows 10!"
            Pause
            $osVer = "10"
            nextSteps
        }   

    }
}else{
    $osVer = Get-Content -Path c:\CYS_begun.txt
    nextSteps
}
# Now, call Script2.ps1 with the same ExecutionPolicy


#Set-ExecutionPolicy Bypass -Scope Process; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/billbowmanwoz/CYSInstallTools/raw/main/pwshinstall/cys_install_win_all.ps1'))