$appsWingetCheck = @("zoom.zoom",
                    "SlackTechnologies.Slack",
                    "WiresharkFoundation.Wireshark",
                    "Oracle.VirtualBox",
                    "TheDocumentFoundation.LibreOffice"
                    "Microsoft.VisualStudioCode",
                    "python3",
                    "Google.Chrome")
$appsWingetInstall = New-Object System.Collections.ArrayList 
foreach ($app in $appsWingetCheck){
    $doesAppExist = winget list $app
    $match = [regex]::Match($doesAppExist, "No installed package found")
    if ($match.Success) {
        $appsWingetInstall += "$app"
    }
}