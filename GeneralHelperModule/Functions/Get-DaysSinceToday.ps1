Function Get-DaysSinceToday {
    <#
		.SYNOPSIS
			Calculates the number of days between today and a specified date

		.DESCRIPTION
			This function calculates how many days have elapsed between the current date and a specified past date.
			Returns a positive number for dates in the past and negative for dates in the future.

		.PARAMETER Year
			The year component of the date

		.PARAMETER Month
			The month component of the date (1-12)

		.PARAMETER Day
			The day component of the date (1-31)

		.EXAMPLE
			Get-DaysSinceToday -Year 2020 -Month 1 -Day 1

			Returns the number of days since January 1, 2020

		.EXAMPLE
			Get-DaysSinceToday -Year 2024 -Month 12 -Day 25

			Calculates days since December 25, 2024

	#>

    [CmdletBinding(PositionalBinding = $False)]
    param(
        [Parameter(Mandatory = $True)][string]$Year,
        [Parameter(Mandatory = $True)][string]$Month,
        [Parameter(Mandatory = $True)][string]$Day
    )
    (Get-Date).Date.Subtract((New-Object DateTime($Year, $Month, $Day))).Days
}

