Function Get-RemoteDisk {
    <#
		.SYNOPSIS
			Gets disk information from a remote computer

		.DESCRIPTION
			This function retrieves disk size, free space, and other information for all local fixed drives on a remote computer using WMI.

		.PARAMETER Name
			The name of the remote computer to query

		.PARAMETER Disk
			Optional parameter to filter for a specific disk (not currently implemented in the function)

		.EXAMPLE
			Get-RemoteDisk -Name "SERVER01"

			Retrieves disk information for all drives on SERVER01

		.EXAMPLE
			Get-RemoteDisk -Name "FILESERVER" | Where-Object {$_.DeviceID -eq "C:"}

			Gets information only for the C: drive on FILESERVER

	#>
    [CmdletBinding(PositionalBinding = $False)]
    [Alias('Get-RemoteDisks')]
    param
    (
        [Parameter(Mandatory = $True)][string]$Name,
        [Parameter(Mandatory = $False)][string]$Disk
    )
    $Computer = Get-WMIObject Win32_Logicaldisk -filter "drivetype='3'" -ComputerName $Name | Select-Object SystemName, DeviceID, VolumeName, @{Name = "Size"; Expression = { "{0:N1}" -f ($_.size / 1gb) } }, @{Name = "Free GB"; Expression = { "{0:N1}" -f ($_.freespace / 1gb) } }
    $Computer
}

