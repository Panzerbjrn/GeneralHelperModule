Function Get-DataTypeName {
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
		[Parameter(Mandatory)]$Value
	)
	return ($value.getType()).name
}
