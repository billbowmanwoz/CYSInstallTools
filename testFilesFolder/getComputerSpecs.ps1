function getDriveSpecs {
    $mainDriveSize = Get-Volume -DriveLetter C
    $driveCapacityinGB = "{0:N2} GB" -f ($mainDriveSize.Size / 1GB)
    $driveCapacityLeftInGB = "{0:N2} GB" -f ($mainDriveSize.SizeRemaining / 1GB)
    Write-Host "The Main Drive has a total size of $driveCapacityinGB"
    Write-Host "And has $driveCapacityLeftInGB remaining"
}


function getProc{
    $ProcInfo = Get-CimInstance Win32_Processor
    $procName = Select-Object Name
    Write-Host "Processor Manufacturer: $ProcInfo.Manufacturer"
    Write-Host "Processor Name:" $procName
    Write-Host "Number of Cores / Logical Processors:+ "$ProcInfo.NumberofCores+ "/" + $ProcInfo.NumberOfProcessors +"`n"   
    $ProcInfo | Select-Object Name, Manufacturer, NumberOfCores, NumberOfLogicalProcessors

}


getProc

getDriveSpecs
