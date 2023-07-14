$NameOfOS = Get-ComputerInfo | Select WindowsProductName
#$OSVersion = Get-ComputerInfo | Select WindowsVersion
if ($NameOfOS -contains "Windows 11"){
    Write-Host "Windows 11! YAY!"
}elseif($NameOfOS -contains "Windows 10"){
    Write-Host "Windows 10"
}


#If $OSVersion 