$sourceDirectory = "D:\resources\2"

# Get a list of all zip files in the source directory
$zipFiles = Get-ChildItem -Path $sourceDirectory -Filter *.zip

# Loop through each zip file and extract its contents to the current folder
foreach ($zipFile in $zipFiles) {
    Expand-Archive -Path $zipFile.FullName -DestinationPath .
}
