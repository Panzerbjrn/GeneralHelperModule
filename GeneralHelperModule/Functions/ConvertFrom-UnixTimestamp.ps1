function ConvertFrom-UnixTimestamp {
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


