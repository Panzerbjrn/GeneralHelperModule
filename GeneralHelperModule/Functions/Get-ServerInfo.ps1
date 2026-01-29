Function Get-ServerInfo {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>

    Get-PSVersion
    Get-LPInstalledRoles
    Get-RunningServices
    Get-LocalDiskSize
    $IPC = ipconfig
    $IPC[8]
}

