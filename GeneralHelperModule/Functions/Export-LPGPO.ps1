Function Export-GPOReport{
	Import-Module GroupPolicy
	Write-Output "Exporting GPO Report to C:\Temp\GPOReport.HTML"
	Get-GPOReport -All -ReportType HTML C:\Temp\GPOReport.HTML
}