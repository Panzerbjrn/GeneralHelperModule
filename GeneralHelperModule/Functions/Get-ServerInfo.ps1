Function Get-ServerInfo {
    <#
		.SYNOPSIS
			Retrieves comprehensive server information

		.DESCRIPTION
			This function gathers multiple pieces of information about the local server including PowerShell version, installed roles, running services, disk sizes, and IP configuration.
			It executes multiple Get functions to provide a complete overview.

		.EXAMPLE
			Get-ServerInfo

			Displays PowerShell version, installed roles, running services, local disk sizes, and network configuration

	#>

    Get-PSVersion
    Get-LPInstalledRoles
    Get-RunningServices
    Get-LocalDiskSize
    $IPC = ipconfig
    $IPC[8]
}

