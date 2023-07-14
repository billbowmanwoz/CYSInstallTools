$systemInfo = systeminfo

$osRegex = $osRegex = 'OS Name:\s+(.+)$'
$buildRegex = '(.+N/A Build )(.+)$'
#$virtRegex_11 = 'Virtualization Enabled in Firmware'

$osName = $systemInfo | Select-String -Pattern $osRegex | ForEach-Object { $_.Matches.Groups[1].Value }
$OSBuildNumber = $systemInfo | Select-String -Pattern $buildRegex | ForEach-Object { $_.Matches.Groups[2].Value }
#$virtEnabled = $systemInfo | Select-String  -Pattern 

if ($osName -match "Windows 11") {
    Write-Host "Windows 11! YAY!"
}elseif($osName -match "Windows 10") {
    Write-Host "Windows 10"
    If ($OSBuildNumber -lt 17134){
        Write-Host "NOSIR, No CYS for you!"
    }else {
        Write-Host "You can do it!"
    }   

}