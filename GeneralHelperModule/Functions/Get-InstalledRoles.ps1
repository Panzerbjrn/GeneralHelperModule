Function Get-InstalledRole {
    <#
		.SYNOPSIS
			Exports installed Windows Features and Roles to a CSV file

		.DESCRIPTION
			This function retrieves all installed Windows Features and Roles using the ServerManager module and exports them to C:\Temp\Roles.CSV.
			The CSV file opens automatically in Notepad after creation.

		.EXAMPLE
			Get-InstalledRole

			Exports all installed roles and features to C:\Temp\Roles.CSV and opens it in Notepad

	#>
    [Alias('Get-InstalledRoles')]
    $TempPath = Test-Path "C:\Temp\"
    if ($TempPath -eq $False) { New-Item -ItemType "Directory" -Path C:\TEMP -Force }
    else {}
    Import-Module Servermanager -Verbose
    Write-Output "Exporting Windows Features & Roles to C:\TEMP\Roles.CSV"
    Get-WindowsFeature | Where-Object { $_.Installed -eq "installed" } | Sort-Object DisplayName | Select-Object *name* | Export-Csv C:\TEMP\Roles.CSV -NoTypeInformation -Delimiter "`t"
    notepad C:\temp\Roles.CSV
}

