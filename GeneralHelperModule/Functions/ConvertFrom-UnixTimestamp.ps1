Function ConvertFrom-UnixTimestamp
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory,ParameterSetName="Seconds")]
		[ValidateNotNullOrEmpty()]
		[string]$Seconds,

		[Parameter(Mandatory,ParameterSetName="Milliseconds")]
		[ValidateNotNullOrEmpty()]
		[string]$Milliseconds
	)

	IF ($Seconds)
	{
		(Get-Date -Date "01/01/1970").AddSeconds($Seconds)
	}
	IF ($MilliSeconds)
	{
		(Get-Date -Date "01/01/1970").AddMilliseconds($MilliSeconds)
	}
}
