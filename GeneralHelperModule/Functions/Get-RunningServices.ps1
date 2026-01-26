function Get-RunningService {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
    [Alias('Get-RunningServices')]
    $TempPath = Test-Path "C:\Temp\"
    if ($TempPath -eq $False) { New-Item -ItemType "Directory" -Path C:\TEMP -Force }
    else {}
    Write-Output "Exporting Windows Services to C:\TEMP\Services.Running.csv"
    Get-Service | Where-Object { $_.Status -eq "Running" } | Sort-Object DisplayName | Select-Object Name, Displayname, status | Export-Csv C:\TEMP\Services.Running.csv -NoTypeInformation -Delimiter "`t"
    notepad C:\temp\Services.CSV
}

