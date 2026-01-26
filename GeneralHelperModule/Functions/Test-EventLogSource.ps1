function Test-EventLogSource {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

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

