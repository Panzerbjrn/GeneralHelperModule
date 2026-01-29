Function Get-RunningService {
    <#
		.SYNOPSIS
			Exports running Windows services to a CSV file

		.DESCRIPTION
			This function retrieves all running Windows services and exports them to C:\Temp\Services.Running.csv.
			The CSV file includes service name, display name, and status, sorted by display name.

		.EXAMPLE
			Get-RunningService

			Exports all running services to C:\Temp\Services.Running.csv and opens it in Notepad

	#>
    [Alias('Get-RunningServices')]
    $TempPath = Test-Path "C:\Temp\"
    if ($TempPath -eq $False) { New-Item -ItemType "Directory" -Path C:\TEMP -Force }
    else {}
    Write-Output "Exporting Windows Services to C:\TEMP\Services.Running.csv"
    Get-Service | Where-Object { $_.Status -eq "Running" } | Sort-Object DisplayName | Select-Object Name, Displayname, status | Export-Csv C:\TEMP\Services.Running.csv -NoTypeInformation -Delimiter "`t"
    notepad C:\temp\Services.CSV
}

