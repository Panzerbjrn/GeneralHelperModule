Function Get-InstalledRoles{
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>

	$TempPath = Test-Path "C:\Temp\"
	IF ($TempPath -eq $False) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
	ELSE {}
	Import-Module Servermanager -Verbose
	Write-Host "Exporting Windows Features & Roles to C:\TEMP\Roles.CSV"
	Get-WindowsFeature | Where-Object {$_.Installed -eq "installed"} | Sort-Object DisplayName | Select-Object *name* | Export-Csv C:\TEMP\Roles.CSV -NoTypeInformation -Delimiter "`t"
	notepad C:\temp\Roles.CSV
}