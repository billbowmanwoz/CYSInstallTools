$appName = "Oracle.Virtualbox"
$appInfo = winget search $appName

$pattern = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\b'
$result = $appInfo | Select-String -Pattern $pattern
$appVersion = $result.Matches.Value

Write-Host "Installing Version $appVersion of $appName"