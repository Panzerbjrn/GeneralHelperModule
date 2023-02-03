Function Test-EventLogSource
{
    Param(
        [Parameter(Mandatory=$True)]
        [string]$LogName
    )
	IF($True -eq (Test-IsAdministrator)){
		[System.Diagnostics.EventLog]::SourceExists($LogName)
	}
	ELSE{
		Write-Error "You need elevated privileges to run this command"
	}
}