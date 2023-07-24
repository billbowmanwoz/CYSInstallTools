$ProcessorInfo = Get-CimInstance Win32_Processor
$ProcessorInfo | Select-Object Name, Manufacturer, MaxClockSpeed, Caption, NumberOfCores, NumberOfLogicalProcessors

$ProcessorInfo