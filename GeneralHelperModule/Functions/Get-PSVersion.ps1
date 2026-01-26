function Get-PSVersion {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>

    $PSVersionTable
    $PSVersionTable.PSVersion
    (Get-WmiObject -class Win32_OperatingSystem).Caption
}
