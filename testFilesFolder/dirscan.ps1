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
