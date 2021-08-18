Function Get-ServerInfo
{
Get-PSVersion
Get-LPInstalledRoles
Get-RunningServices
Get-LocalDiskSize
$IPC = ipconfig
$IPC[8]
}