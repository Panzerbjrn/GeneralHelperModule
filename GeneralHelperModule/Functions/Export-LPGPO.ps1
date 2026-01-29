Ffunction Export-GPOReport {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
    Import-Module GroupPolicy
    Write-Output "Exporting GPO Report to C:\Temp\GPOReport.HTML"
    Get-GPOReport -All -ReportType HTML C:\Temp\GPOReport.HTML
}

