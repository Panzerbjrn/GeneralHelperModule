function Get-DaysSinceToday {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it
	#>

    [CmdletBinding(PositionalBinding = $False)]
    param(
        [Parameter(Mandatory = $True)][string]$Year,
        [Parameter(Mandatory = $True)][string]$Month,
        [Parameter(Mandatory = $True)][string]$Day
    )
    (Get-Date).Date.Subtract((New-Object DateTime($Year, $Month, $Day))).Days
}

