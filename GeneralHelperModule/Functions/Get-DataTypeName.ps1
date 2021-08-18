Function Get-DataTypeName {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]$Value
	)
	return ($value.getType()).name
}
