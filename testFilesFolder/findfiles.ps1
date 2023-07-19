$appsWingetCheck = @("zoom.zoom",
                    "SlackTechnologies.Slack",
                    "WiresharkFoundation.Wireshark",
                    "Oracle.VirtualBox",
                    "TheDocumentFoundation.LibreOffice"
                    "Microsoft.VisualStudioCode",
                    "python3",
                    "Google.Chrome",
                    "Brave.Brave")
$appsWingetInstall = New-Object System.Collections.ArrayList
$appsWingetUpgrade = New-Object System.Collections.ArrayList 
foreach ($app in $appsWingetCheck){
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
Write-Host -ForegroundColor Red "To install"
Write-Output $appsWingetInstall
Write-Host -ForegroundColor Green "To Upgrade"
Write-Output $appsWingetUpgrade