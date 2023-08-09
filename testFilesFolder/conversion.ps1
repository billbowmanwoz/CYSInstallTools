$virtInfo = systeminfo | Select-String -Pattern 'Virtualization Enabled In Firmware'

if ($virtInfo = 'Virtualization Enabled In Firmware: Yes'){
    Write-Host "Virtualization is Enabled"
}else{
    Write-Host "Virtulization is NOT enabled"
}
