Function Get-LocalDiskSize {
    <#
		.SYNOPSIS
			Gets disk size information for local drives

		.DESCRIPTION
			This function retrieves disk size, free space, and percentage free for all local fixed drives on the current computer using CIM instances.

		.EXAMPLE
			Get-LocalDiskSize

			Displays disk information for all local fixed drives including system name, device ID, volume name, size, free space, and percentage free

	#>

    #$TempPath = Test-Path "C:\Temp\"
    #IF ($TempPath -eq $False) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
    Write-Output "Getting Disk Sizes"
    Get-CimInstance -ClassName Win32_LogicalDisk -filter "DriveType=3" | select-object SystemName, DeviceID, VolumeName, @{Name = "Size"; Expression = { "{0:N1}" -f ($_.size / 1gb) } }, @{Name = "Free"; Expression = { "{0:N1}" -f ($_.freespace / 1gb) } }, @{Name = "Percent"; Expression = { [int]($_.FreeSpace / $_.Size * 100) } }
    #Get-WmiObject Win32_LogicalDisk -filter "DriveType=3" -computer $ENV:Computername | Select-Object SystemName,DeviceID,VolumeName,@{Name="Size";Expression={"{0:N1}" -f($_.size/1gb)}}

    #| Export-Csv C:\TEMP\DiskSize.CSV -NoTypeInformation -Delimiter "`t"

    #notepad C:\temp\DiskSize.CSV
}

