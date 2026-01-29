Function Test-IsAdministrator {
    <#
	.SYNOPSIS
	Tests if the user is an administrator

	.Description
	Returns true if a user is an administrator, false if the user is not an administrator

	.Example
	Test-IsAdministrator

	.Notes
	NAME: Test-IsAdministrator
	AUTHOR: Ed Wilson
	LASTEDIT: 5/20/2009
	KEYWORDS:

	.Link
	Http://www.ScriptingGuys.com

	#Requires -Version 2.0
#>
    param()
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

