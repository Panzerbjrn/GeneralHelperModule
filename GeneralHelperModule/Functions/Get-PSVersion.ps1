Function Get-PSVersion
{
$PSVersionTable
$PSVersionTable.PSVersion
(Get-WmiObject -class Win32_OperatingSystem).Caption
}