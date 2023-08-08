$drives = Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID, FreeSpace, Size
$driveInfo = $drives | ForEach-Object {
    [PSCustomObject]@{
        'Drive Letters' = $_.DeviceID -replace ':'
        'Free Space (GB)' = [math]::Round($_.FreeSpace / 1GB, 2)
        'Total Size (GB)' = [math]::Round($_.Size / 1GB, 2)
    }
}
$driveInfo | Format-Table -AutoSize
