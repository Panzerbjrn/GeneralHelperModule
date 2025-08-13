Function Connect-RDP {
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding(PositionalBinding=$False)]
	Param(
		[Parameter(Mandatory=$True)][string]$Server
	)
		MSTSC /v:$Server /ADMIN /F
}