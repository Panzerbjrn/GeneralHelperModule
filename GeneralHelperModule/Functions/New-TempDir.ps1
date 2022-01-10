Function New-TempDir {
	[CmdletBinding()]
	[Alias('Create-TempDir')]
	Param()

	IF	(!(Test-Path -Path C:\Temp)) {New-Item -ItemType "Directory" -Path C:\Temp -Force}
}