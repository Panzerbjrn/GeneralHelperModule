Function ConvertFrom-UnixTimestamp {
    <#
		.SYNOPSIS
			Converts Unix timestamps to DateTime objects

		.DESCRIPTION
			This function converts Unix epoch timestamps (seconds or milliseconds since January 1, 1970) to PowerShell DateTime objects.
			Supports both seconds-based and milliseconds-based Unix timestamps.

		.PARAMETER Seconds
			Unix timestamp in seconds since January 1, 1970

		.PARAMETER Milliseconds
			Unix timestamp in milliseconds since January 1, 1970

		.EXAMPLE
			ConvertFrom-UnixTimestamp -Seconds 1609459200

			Converts the Unix timestamp to a DateTime object representing 2021-01-01 00:00:00

		.EXAMPLE
			ConvertFrom-UnixTimestamp -Milliseconds 1609459200000

			Converts the Unix timestamp in milliseconds to a DateTime object

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ParameterSetName = "Seconds")]
        [ValidateNotNullOrEmpty()]
        [string]$Seconds,

        [Parameter(Mandatory, ParameterSetName = "Milliseconds")]
        [ValidateNotNullOrEmpty()]
        [string]$Milliseconds
    )

    if ($Seconds) {
        (Get-Date -Date "01/01/1970").AddSeconds($Seconds)
    }
    if ($MilliSeconds) {
        (Get-Date -Date "01/01/1970").AddMilliseconds($MilliSeconds)
    }
}


