$NameOfOS = Get-ComputerInfo -Property OSName
$OSVersion = Get-ComputerInfo -Property OSBuildnumber

if ($NameOfOS -match "Windows 11") {
    Write-Host "Windows 11! YAY!"
}elseif($NameOfOS -match "Windows 10") {
    Write-Host "Windows 10"
}


#If $OSVersion 