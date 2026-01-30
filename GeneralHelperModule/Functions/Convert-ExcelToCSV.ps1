Function Convert-ExcelToCSV ($Path, $ExcelFileName, $CSVLoc) {
    <#
		.SYNOPSIS
			Converts Excel worksheets to CSV files

		.DESCRIPTION
			This function opens an Excel file and exports each worksheet as a separate CSV file.
			Each CSV file is named using the Excel filename and worksheet name.

		.PARAMETER Path
			The directory path where the Excel file is located

		.PARAMETER ExcelFileName
			The name of the Excel file to convert (including .xlsx or .xls extension)

		.PARAMETER CSVLoc
			The directory path where the CSV files should be saved

		.EXAMPLE
			Convert-ExcelToCSV -Path "C:\Data" -ExcelFileName "Report.xlsx" -CSVLoc "C:\Export"

			Converts all worksheets in Report.xlsx to separate CSV files in C:\Export

		.NOTES
			Requires Excel to be installed
			If run non-interactively, these directories must exist:
			- C:\Windows\SysWOW64\config\systemprofile\Desktop
			- C:\Windows\System32\config\systemprofile\Desktop
			Reference: https://docs.microsoft.com/en-us/office/vba/api/excel.xlfileformat

	#>
    [CmdletBinding()]
    $ExcelFile = Join-Path -Path $Path -ChildPath $ExcelFileName
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $False
    $E.DisplayAlerts = $False
    $WB = $E.Workbooks.Open($ExcelFile)
    ForEach ($WS in $WB.Worksheets) {
        $N = $ExcelFileName.Replace('.xlsx', '').Replace('.xls', '') + "_" + $WS.Name
        $SaveAs = $(Join-Path -Path $csvLoc -ChildPath $N) + ".csv"
        $WS.SaveAs($SaveAs, 6)
    }
    $E.Quit()
}


