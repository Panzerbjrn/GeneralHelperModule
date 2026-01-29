Function New-TempDir {
    <#
		.SYNOPSIS
			Creates the C:\Temp directory if it doesn't exist

		.DESCRIPTION
			This function checks for the existence of C:\Temp and creates it if it's not present.
			Supports ShouldProcess for -WhatIf and -Confirm functionality.

		.EXAMPLE
			New-TempDir

			Creates C:\Temp if it doesn't already exist

		.EXAMPLE
			New-TempDir -WhatIf

			Shows what would happen without actually creating the directory

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Create-TempDir')]
    param()
    BEGIN {}
    PROCESS {
        if ($pscmdlet.ShouldProcess("location C:\Temp")) {
            if (!(Test-Path -Path C:\Temp)) { New-Item -ItemType "Directory" -Path C:\Temp -Force }
        }
    }
    END {}
}

