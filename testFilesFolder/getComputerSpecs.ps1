# $sysinfo = {
#     systeminfo
# }

#$vmStatus = Start-Job -ScriptBlock $sysInfo | Select-String -Pattern 'Virtualization Enabled In Firmware'
function getOS {
    $osName = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption
    Write-Host "`n`nThe Current Operating System software is:" $osName.Caption "`n"
}
# function getDriveSpecs {
#     $mainDriveSize = Get-Volume -DriveLetter C
#     $driveCapacityinGB = "{0:N2} GB" -f ($mainDriveSize.Size / 1GB)
#     $driveCapacityLeftInGB = "{0:N2} GB" -f ($mainDriveSize.SizeRemaining / 1GB)
#     Write-Host "The Main Drive has a total size of $driveCapacityinGB"
#     Write-Host "And has $driveCapacityLeftInGB remaining`n"
# }
function getDriveSpecs{
    $drives = Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID, FreeSpace, Size
    $driveInfo = $drives | ForEach-Object {
    [PSCustomObject]@{
        'Drive Letter' = $_.DeviceID
        'Free Space (GB)' = [math]::Round($_.FreeSpace / 1GB, 2)
        'Total Size (GB)' = [math]::Round($_.Size / 1GB, 2)
    }
}
$driveInfo | Format-Table -AutoSize
}
function getProc{
    $ProcessorInfo = Get-CimInstance Win32_Processor
    $ProcName = $ProcessorInfo | Select-Object Name
    $ProcCores = $ProcessorInfo | Select-Object NumberOfCores
    $ProcThreads = $ProcessorInfo | Select-Object NumberOfLogicalProcessors

    Write-Host "Processor Name:" $procName.Name
    Write-Host "Number of Cores / Logical Processors: "$ProcCores.NumberOfCores "/"$ProcThreads.NumberOfLogicalProcessors"`n"   
}
function getRAM{
    $ram = Get-WmiObject -Class Win32_ComputerSystem | Select-Object TotalPhysicalMemory
    $ramSizeGB = $ram.TotalPhysicalMemory / 1GB
    $ramOutPut = "RAM Size: {0:N2} GB`n" -f $ramSizeGB
    Write-Host $ramOutPut
}
# function getVMStatus {
#     if ($vmStatus = 'Virtualization Enabled In Firmware: Yes'){
#         Write-Host "Virtualization is Enabled"
#     }else{
#         Write-Host -Foreground Color Red -BackgroundColor = White "Virtualization is NOT enabled"
#     }
# }


Clear-Host
getOS
getProc
getRAM
#getVMStatus
getDriveSpecs
#Pause
