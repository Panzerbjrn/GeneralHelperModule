Function Export-GPOReport {
    <#
		.SYNOPSIS
			Exports all Group Policy Objects to an HTML report

		.DESCRIPTION
			This function uses the GroupPolicy module to export a comprehensive HTML report of all GPOs in the domain to C:\Temp\GPOReport.HTML.

		.EXAMPLE
			Export-GPOReport

			Exports all GPOs to C:\Temp\GPOReport.HTML

	#>
    Import-Module GroupPolicy
    Write-Output "Exporting GPO Report to C:\Temp\GPOReport.HTML"
    Get-GPOReport -All -ReportType HTML C:\Temp\GPOReport.HTML
}

