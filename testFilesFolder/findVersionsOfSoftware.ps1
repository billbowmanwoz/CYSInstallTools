# $appVersion = ""
$appName = "Oracle.Virtualbox"

# $appInfo = winget search $appName


# #$appVersion = $appInfo | Select-String -Pattern '\b\d{1,3}\.\d{1,3}\.\d{1,3}\b'
# if ($appInfo -match '\b\d+\.\d+\.\d+\b') {
#     $appVersion = $matches
# } else {
#     Write-Host "Not found"
# }
# Write-Host $appVersion

# Sample string
$appInfo = winget search $appName
#$appInfoClean = $appInfo -replace '^[^0-9]*',''

$appInfoLines = $appInfo -split 'a-zA-Z' | Where-Object { $_ -ne ''}
$appInfoLines
 # Using regex to extract the version number
 if ($appInfoLines -match '\b\d+\.\d+\.\d+\b') {
     $versionNumber = $matches
     Write-Host "Version number: $versionNumber"
 } else {
     Write-Host "No version number found in the string."
 }

