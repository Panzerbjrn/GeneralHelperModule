Function Connect-RDP {
	[CmdletBinding(PositionalBinding=$false)]
	Param
		(
			[Parameter(Mandatory=$True)][string]$Server
		)
		MSTSC /v:$Server /ADMIN /F
}