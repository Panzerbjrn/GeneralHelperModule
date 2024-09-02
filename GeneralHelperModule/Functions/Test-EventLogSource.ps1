Function Test-EventLogSource{
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding()]
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