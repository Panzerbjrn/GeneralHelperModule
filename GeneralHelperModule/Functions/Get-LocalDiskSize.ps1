function Get-LocalDiskSize {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>

    #$TempPath = Test-Path "C:\Temp\"
    #IF ($TempPath -eq $False) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
    Write-Output "Getting Disk Sizes"
    Get-CimInstance -ClassName Win32_LogicalDisk -filter "DriveType=3" | select-object SystemName, DeviceID, VolumeName, @{Name = "Size"; Expression = { "{0:N1}" -f ($_.size / 1gb) } }, @{Name = "Free"; Expression = { "{0:N1}" -f ($_.freespace / 1gb) } }, @{Name = "Percent"; Expression = { [int]($_.FreeSpace / $_.Size * 100) } }
    #Get-WmiObject Win32_LogicalDisk -filter "DriveType=3" -computer $ENV:Computername | Select-Object SystemName,DeviceID,VolumeName,@{Name="Size";Expression={"{0:N1}" -f($_.size/1gb)}}

    #| Export-Csv C:\TEMP\DiskSize.CSV -NoTypeInformation -Delimiter "`t"
	
    #notepad C:\temp\DiskSize.CSV
}

