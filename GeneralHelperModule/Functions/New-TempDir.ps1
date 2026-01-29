Function New-TempDir {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

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

