Function Get-PSVersion {
    <#
		.SYNOPSIS
			Displays PowerShell version and operating system information

		.DESCRIPTION
			This function retrieves and displays the PowerShell version table, the specific PowerShell version number, and the Windows operating system caption.
			Useful for quickly checking the PowerShell and OS versions on a system.

		.EXAMPLE
			Get-PSVersion

			Displays the complete PSVersionTable, PowerShell version number, and OS caption

	#>

    $PSVersionTable
    $PSVersionTable.PSVersion
    (Get-WmiObject -class Win32_OperatingSystem).Caption
}

