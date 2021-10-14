Function Create-TempDir {
	IF	(!(Test-Path -Path C:\Temp)) {New-Item -ItemType "Directory" -Path C:\Temp -Force}
}