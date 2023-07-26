$URLs = @("https://login.exeterlms.com/account/login",
        "https://office.com",
        "https://connect.scitexas.edu")
$siteTitles = @("Exeter LMS Signin Page",
        "Microsoft Office Signin Page",
        "Reset Microsoft Password Page (Use the 'Need Help Logging In' Link)")

$length = $URLs.Length

for ($i = 0; $i -lt $length; $i++) {
    $URL = $URLs[$i]
    $title = $siteTitles[$i]
    $desktopPath = [Environment]::GetFolderPath('Desktop')
    $ShortcutPath = "$desktopPath\$title.url"
    $TargetPath = "$URL"  # The target application, in this case, using cmd.exe to open the URL
    
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $TargetPath
    $Shortcut.Save()
}