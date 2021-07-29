Function Get-LocalDiskSize
{
$TempPath = Test-Path "C:\Temp\"
IF ($TempPath -eq $False) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
ELSE {}
Write-Host "Getting Disk Sizes"
Get-WmiObject Win32_LogicalDisk -filter "DriveType=3" -computer $ENV:Computername | Select-Object SystemName,DeviceID,VolumeName,@{Name="Size";Expression={"{0:N1}" -f($_.size/1gb)}} | Export-Csv C:\TEMP\DiskSize.CSV -NoTypeInformation -Delimiter "`t"
notepad C:\temp\DiskSize.CSV
}