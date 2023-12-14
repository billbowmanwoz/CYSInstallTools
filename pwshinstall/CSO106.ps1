$desktopPath = [System.Environment]::GetFolderPath("Desktop")

$pythonFolder = Join-Path -Path $desktopPath -ChildPath "CSO106"
New-Item -ItemType Directory -Path $pythonFolder

for ($i = 1; $i -le 10; $i++) {
    $lessonFolderName = "Lesson $i"
    $lessonFolderPath = Join-Path -Path $pythonFolder -ChildPath $lessonFolderName
    New-Item -ItemType Directory -Path $lessonFolderPath
}