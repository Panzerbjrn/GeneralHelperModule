Function Test-IsAdministrator {
    <#
		.SYNOPSIS
			Tests if the user is an administrator

		.DESCRIPTION
			Returns true if a user is an administrator, false if the user is not an administrator

		.EXAMPLE
			Test-IsAdministrator

			Returns $true if running as administrator, $false otherwise

		.NOTES
			NAME: Test-IsAdministrator
			AUTHOR: Ed Wilson
			LASTEDIT: 5/20/2009
			KEYWORDS:

		.LINK
			Http://www.ScriptingGuys.com

	#>
    param()
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

