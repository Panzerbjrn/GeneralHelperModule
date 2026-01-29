Function Get-RemoteDisk {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

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

