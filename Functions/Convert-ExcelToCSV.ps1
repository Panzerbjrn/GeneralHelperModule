Function Convert-ExcelToCSV ($Path,$ExcelFileName,$CSVLoc)
{
	#https://docs.microsoft.com/en-us/office/vba/api/excel.xlfileformat
	#Must exist if run non-interactively:
	#mkdir C:\Windows\SysWOW64\config\systemprofile\Desktop
	#mkdir C:\Windows\System32\config\systemprofile\Desktop
    $ExcelFile = Join-Path -Path $Path -ChildPath $ExcelFileName
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $WB = $E.Workbooks.Open($ExcelFile)
    ForEach ($WS in $WB.Worksheets)
    {
        $N = $ExcelFileName.Replace('.xlsx','').Replace('.xls','') + "_" + $WS.Name
		$SaveAs = $(Join-Path -Path $csvLoc -ChildPath $N) + ".csv"
        $WS.SaveAs($SaveAs, 6)
    }
    $E.Quit()
}
