function getDriveSpecs {
    $mainDriveSize = Get-Volume -DriveLetter C
    $driveCapacityinGB = "{0:N2} GB" -f ($mainDriveSize.Size / 1GB)
    $driveCapacityLeftInGB = "{0:N2} GB" -f ($mainDriveSize.SizeRemaining / 1GB)
}


function getCompSpec{
    
}



getDriveSpecs
Write-Host "The Main Drive has a total size of $driveCapacityinGB"
Write-Host "And has $driveCapacityLeftInGB remaining"