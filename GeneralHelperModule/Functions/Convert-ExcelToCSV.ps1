function Convert-ExcelToCSV ($Path, $ExcelFileName, $CSVLoc) {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it
        .NOTES
            #https://docs.microsoft.com/en-us/office/vba/api/excel.xlfileformat
            #Must exist if run non-interactively:
            #mkdir C:\Windows\SysWOW64\config\systemprofile\Desktop
            #mkdir C:\Windows\System32\config\systemprofile\Desktop

	#>
    [CmdletBinding()]
    $ExcelFile = Join-Path -Path $Path -ChildPath $ExcelFileName
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $False
    $E.DisplayAlerts = $False
    $WB = $E.Workbooks.Open($ExcelFile)
    foreach ($WS in $WB.Worksheets) {
        $N = $ExcelFileName.Replace('.xlsx', '').Replace('.xls', '') + "_" + $WS.Name
        $SaveAs = $(Join-Path -Path $csvLoc -ChildPath $N) + ".csv"
        $WS.SaveAs($SaveAs, 6)
    }
    $E.Quit()
}


