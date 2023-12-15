$desktopPath = [System.Environment]::GetFolderPath("Desktop")
$pythonFolder = Join-Path -Path $desktopPath -ChildPath "CSO106"
New-Item -ItemType Directory -Path $pythonFolder

for ($i = 1; $i -le 10; $i++) {
    $lessonFolderName = "Lesson $i"
    $lessonFolderPath = Join-Path -Path $pythonFolder -ChildPath $lessonFolderName
    New-Item -ItemType Directory -Path $lessonFolderPath

    $mainPyFilePath = Join-Path -Path $lessonFolderPath -ChildPath "main.py"
    Set-Content -Path $mainPyFilePath -Value "# Your Python template for Lesson $i Hands-On assignment"

    $additionalPyFilePath = Join-Path -Path $lessonFolderPath -ChildPath "practice.py"
    Set-Content -Path $additionalPyFilePath -Value "# Practice Python template for Lesson $i"
}
