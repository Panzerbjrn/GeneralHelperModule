Function New-TempDir {
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding()]

	[Alias('Create-TempDir')]
	Param()

	IF	(!(Test-Path -Path C:\Temp)) {New-Item -ItemType "Directory" -Path C:\Temp -Force}
}