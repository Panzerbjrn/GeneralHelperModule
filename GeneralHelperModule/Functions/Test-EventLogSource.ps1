Function Test-EventLogSource {
    <#
		.SYNOPSIS
			Tests if an Event Log source exists

		.DESCRIPTION
			This function checks whether a specified Event Log source exists on the local system.
			Requires administrator privileges to query Event Log sources.

		.PARAMETER LogName
			The name of the Event Log source to check

		.EXAMPLE
			Test-EventLogSource -LogName "Application"

			Returns $true if the Application Event Log source exists, $false otherwise

		.EXAMPLE
			Test-EventLogSource -LogName "MyCustomApp"

			Checks if a custom Event Log source named MyCustomApp exists

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [string]$LogName
    )
    if ($True -eq (Test-IsAdministrator)) {
        [System.Diagnostics.EventLog]::SourceExists($LogName)
    }
    else {
        Write-Error "You need elevated privileges to run this command"
    }
}

