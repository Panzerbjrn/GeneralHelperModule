Function Get-CombinedFileSize {
    <#
		.SYNOPSIS
			Gets the combined size of files from Get-ChildItem output

		.DESCRIPTION
			This function takes the output from Get-ChildItem (either piped directly or passed as a parameter)
			and calculates the combined size of all files. The result is returned as a human-readable string
			using the Format-DiskSize helper function.

		.PARAMETER Files
			The file objects from Get-ChildItem. Accepts pipeline input.

		.EXAMPLE
			Get-ChildItem -Path "C:\Logs" | Get-CombinedFileSize

			Returns the combined size of all files in the C:\Logs directory.

		.EXAMPLE
			Get-CombinedFileSize -Files (Get-ChildItem -Path "C:\Logs" -Recurse)

			Returns the combined size of all files in the C:\Logs directory and its subdirectories.

		.EXAMPLE
			$Files = Get-ChildItem -Path "C:\Logs"
			Get-CombinedFileSize -Files $Files

			Stores files in a variable first, then returns the combined size.

	#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [System.IO.FileSystemInfo[]]$Files
    )

    begin {
        [long]$TotalSize = 0
        [int]$FileCount = 0
    }

    process {
        foreach ($File in $Files) {
            if ($File -is [System.IO.FileInfo]) {
                $TotalSize += $File.Length
                $FileCount++
            }
        }
    }

    end {
        [PSCustomObject]@{
            FileCount     = $FileCount
            TotalSizeRaw  = $TotalSize
            TotalSize     = Format-DiskSize -size $TotalSize
        }
    }
}

