Function Get-RandomString{
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding()]
	Param (
		[Parameter(ParameterSetName="Hex",Position=0)]
		[Parameter(ParameterSetName="Dec",Position=0)]
		[Parameter(ParameterSetName="AlphaNum",Position=0)]
		[int]$NumberOfCharacters="3",

		[Parameter(ParameterSetName="Hex",Position=1)]
		[switch]$Hexidecimal,

		[Parameter(ParameterSetName="Dec",Position=1)]
		[switch]$Decimal,

		[Parameter(ParameterSetName="AlphaNum",Position=1)]
		[switch]$AlphaNumeric
	)
	$PSCmdlet.ParameterSetName
	IF($Hexidecimal)
	{
		-Join((48..57) + (65..72) | Get-Random -Count $NumberOfCharacters | ForEach-Object {[char]$_})
	}
	IF($Decimal)
	{
		-join ((0..9) | Get-Random -Count $NumberOfCharacters | ForEach-Object {$_})
	}
	IF($AlphaNumeric)
	{
		-Join((48..57) + (65..90) + (97..122) | Get-Random -Count $NumberOfCharacters | ForEach-Object {[char]$_})
	}
}
