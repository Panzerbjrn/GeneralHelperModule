Function Export-WorkSheetToCSV ($Path,$ExcelFileName,$CSVLoc){
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it
        .NOTES
        #Must exist if run non-interactively:
        #mkdir C:\Windows\SysWOW64\config\systemprofile\Desktop
        #mkdir C:\Windows\System32\config\systemprofile\Desktop
	#>
    $ExcelFile = Join-Path -Path $Path -ChildPath $ExcelFileName
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $WB = $E.Workbooks.Open($ExcelFile)
    ForEach ($WS in $WB.Worksheets){
        $N = $ExcelFileName + "_" + $WS.Name
        $WS.SaveAs($csvLoc + $N + ".csv", 6)
    }
    $E.Quit()
}
