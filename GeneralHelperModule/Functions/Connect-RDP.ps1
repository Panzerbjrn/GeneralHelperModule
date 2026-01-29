Function Connect-RDP {
    <#
		.SYNOPSIS
			Connects to a remote server using Remote Desktop Protocol (RDP)

		.DESCRIPTION
			This function launches a Remote Desktop (mstsc) connection to a specified server in full-screen administrator mode.

		.PARAMETER Server
			The name or IP address of the server to connect to

		.EXAMPLE
			Connect-RDP -Server "SQLSERVER01"

			Connects to SQLSERVER01 via RDP in full-screen administrator mode

		.EXAMPLE
			Connect-RDP -Server "192.168.1.100"

			Connects to the server at IP 192.168.1.100 via RDP

	#>
    [CmdletBinding(PositionalBinding = $False)]
    param(
        [Parameter(Mandatory = $True)][string]$Server
    )
    MSTSC /v:$Server /ADMIN /F
}

