Function Export-LPGPO{
	Import-Module GroupPolicy
	Write-Host "Exporting GPO Report to C:\Temp\GPOReport.HTML"
	Get-GPOReport -All -ReportType HTML C:\Temp\GPOReport.HTML
}