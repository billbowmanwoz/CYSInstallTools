# Define the directory path
$directoryPath = "$OVAFolder"

# Define the array to store file paths
$fileArray = @()

# Define the specific file extensions you want to include (e.g., .txt, .docx, .xlsx, etc.)
$extensions = @(".ova")

# Get the files in the directory with the specified extensions
$files = Get-ChildItem -Path $directoryPath -Filter "*$($extensions -join '|')" -File

# Loop through the files and add their paths to the array
foreach ($file in $files) {
    $fileArray += $file.FullName
}

# Output the contents of the array (optional)
$fileArray
https://dl.dropbox.com/s/wo5lkj6ps7avz40/ubuntu-22.04.1-live-server-amd64.iso
https://dl.dropbox.com/scl/fi/snx6yh5a9phz30gwrv86a/ubuntu-22.04.1-live-server-amd64.iso.sha?rlkey=648qz1xpiw265athy7ghor2w4