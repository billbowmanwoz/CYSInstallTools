$drives = Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID, FreeSpace, Size, VolumeName
$driveInfo = $drives | ForEach-Object {
    $diskDrive = Get-CimInstance Win32_DiskDrive | Where-Object { $_.DeviceID -eq ($_.__PATH -replace '\\', '') }
    [PSCustomObject]@{
        'Drive Letters' = $_.DeviceID -replace ':'
        'Free Space (GB)' = [math]::Round($_.FreeSpace / 1GB, 2)
        'Total Size (GB)' = [math]::Round($_.Size / 1GB, 2)
        'Volume Label' = $_.VolumeName
        'Drive Type' = $diskDrive.MediaType
    }
}
$driveInfo | Format-Table -AutoSize
