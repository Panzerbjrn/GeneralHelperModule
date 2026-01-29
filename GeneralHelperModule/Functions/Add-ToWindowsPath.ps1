Function Add-ToWindowsPath {
    <#
		.SYNOPSIS
			Adds a directory to the Windows system PATH environment variable

		.DESCRIPTION
			This function adds a specified directory path to the system-wide PATH environment variable in the Windows registry.
			Requires administrator privileges to modify the system PATH.

		.PARAMETER Path
			The full path to the directory to add to the system PATH

		.EXAMPLE
			Add-ToWindowsPath -Path "C:\MyApp\bin"

			Adds C:\MyApp\bin to the system PATH environment variable

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (Test-Path $Path) {
        if (-not (Test-IsAdministrator)) {
            return "You are not root. Root permissions are needed."
        }
        if (Test-IsAdministrator) {
            $OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
            $NewPath = $OldPath + ';' + $Path
            Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath
            Write-Verbose "New Windows Environment Path is $((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path)"
        }
    }
    else {
        throw "Path $Path not found. Please check and try again"
    }
}

