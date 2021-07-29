Function Get-DaysSinceToday {
	[CmdletBinding(PositionalBinding=$false)]
Param
	(
		[Parameter(Mandatory=$True)][string]$Year,
		[Parameter(Mandatory=$True)][string]$Month,
		[Parameter(Mandatory=$True)][string]$Day
	)
	(Get-Date).Date.Subtract((New-Object DateTime($Year,$Month,$Day))).Days
}