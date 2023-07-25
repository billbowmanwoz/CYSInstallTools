#$ProcessorInfo | Select-Object Name, Manufacturer, MaxClockSpeed, Caption, NumberOfCores, NumberOfLogicalProcessors
#Get-WmiObject -Class Win32_ComputerSystem | Select-Object TotalPhysicalMemory

$ProcessorInfo = Get-CimInstance Win32_Processor
$ram = Get-WmiObject -Class Win32_ComputerSystem | Select-Object TotalPhysicalMemory

$ramSizeGB = $ram.TotalPhysicalMemory / 1GB
$ramOutPut = "RAM Size: {0:N2} GB" -f $ramSizeGB
$ProcName = $ProcessorInfo | Select-Object Name

Write-Host "Installed Processor is:" $ProcName.Name
Write-Host $ramOutPut