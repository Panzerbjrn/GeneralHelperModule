Function Format-DiskSize {
    <#
		.SYNOPSIS
			Formats byte sizes into human-readable strings

		.DESCRIPTION
			This function converts raw byte values into human-readable format with appropriate units (B, KB, MB, GB, TB, PB).
			Automatically selects the most appropriate unit based on the size.

		.PARAMETER size
			The size in bytes to format

		.EXAMPLE
			Format-DiskSize -size 1073741824

			Returns "1GB"

		.EXAMPLE
			Format-DiskSize -size 524288000

			Returns "500MB"

		.EXAMPLE
			Get-ChildItem C:\Files | Select-Object Name, @{N="Size";E={Format-DiskSize $_.Length}}

			Displays files with formatted size column

	#>
    [CmdletBinding()]
    param ($size)
    switch ($size) {
        { $_ -ge 1PB } { "{0:0.#}PB" -f ($size / 1PB); break }
        { $_ -ge 1TB } { "{0:0.#}TB" -f ($size / 1TB); break }
        { $_ -ge 1GB } { "{0:0.#}GB" -f ($size / 1GB); break }
        { $_ -ge 1MB } { "{0:0.#}MB" -f ($size / 1MB); break }
        { $_ -ge 1KB } { "{0:0}KB" -f ($size / 1KB); break }
        default { "{0}B" -f $size }
    }
}


