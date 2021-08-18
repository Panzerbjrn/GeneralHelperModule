Function Get-RunningServices
{
$TempPath = Test-Path "C:\Temp\"
IF ($TempPath -eq $False) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
ELSE {}
Write-Host "Exporting Windows Services to C:\TEMP\Roles.CSV"
Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object DisplayName | Select-Object Name,Displayname,status | Export-Csv C:\TEMP\Services.CSV -NoTypeInformation -Delimiter "`t"
notepad C:\temp\Services.CSV
}