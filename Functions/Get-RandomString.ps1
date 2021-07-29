Function Get-RandomString
{
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory=$False,ParameterSetName="Hex",Position=0)]
		[Parameter(Mandatory=$False,ParameterSetName="Dec",Position=0)]
		[Parameter(Mandatory=$False,ParameterSetName="AlphaNum",Position=0)]
		[int]$NumberOfCharacters="3",

		[Parameter(Mandatory=$False,ParameterSetName="Hex",Position=1)]
		[switch]$Hexidecimal,

		[Parameter(Mandatory=$False,ParameterSetName="Dec",Position=1)]
		[switch]$Decimal,

		[Parameter(Mandatory=$False,ParameterSetName="AlphaNum",Position=1)]
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
