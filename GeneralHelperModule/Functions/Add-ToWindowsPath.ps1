Function Add-ToWindowsPath{
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[string]$Path
	)
	
	IF (Test-Path $Path){
			IF (-not (Test-IsAdministrator))
			{
				return "You are not root. Root permissions are needed."
			}
			IF (Test-IsAdministrator)
			{
				$OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
				$NewPath = $OldPath + ';' + $Path
				Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath
				Write-Verbose "New Windows Environment Path is $((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path)"
			}
	}
	ELSE{
		throw "Path $Path not found. Please check and try again"
	}
}