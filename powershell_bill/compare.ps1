$NameOfOS = Get-ComputerInfo -Property OSName
$OSVersionRaw = Get-ComputerInfo -Property OSBuildnumber
$regexPattern = "(?<=\=)(.*)$"
$OSVer = [regex]::Match($OSVersionRaw, $regexPattern)
if ($match.Success){
    $result = $match.Groups[1].Value.Trim()
    Write-Host "Extracted information: $result"
}

if ($NameOfOS -match "Windows 11") {
    Write-Host "Windows 11! YAY!"
}elseif($NameOfOS -match "Windows 10") {
    Write-Host "Windows 10"
}

If ($OSVersion -lt 17134){
    Write-Host "NOSIR, No CYS for you!"
}else {
    Write-Host "You can do it!"
}