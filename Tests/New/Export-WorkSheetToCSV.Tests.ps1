BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Export-WorkSheetToCSV' -Tag 'Export-WorkSheetToCSV', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Export-WorkSheetToCSV -ErrorAction Stop } | Should -Not -Throw
    }

  }

  Context 'When validating parameters' {

    It 'Should require Path parameter' {

      { Export-WorkSheetToCSV -ErrorAction Stop } | Should -Throw
    }

    It 'Should require ExcelFileName parameter' {

      { Export-WorkSheetToCSV -Path "C:\Test" -ErrorAction Stop } | Should -Throw
    }

    It 'Should require CSVLoc parameter' {

      { Export-WorkSheetToCSV -Path "C:\Test" -ExcelFileName "test.xlsx" -ErrorAction Stop } | Should -Throw
    }

  }

  Context 'When Excel is not available' {

    BeforeAll {

      $excelAvailable = $null -ne (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\App` Paths\excel.exe -ErrorAction SilentlyContinue)
    }

    It 'Should skip if Excel is not installed' -Skip:($excelAvailable) {

      Set-ItResult -Skipped -Because "Excel is not installed on this system"
    }

  }

}

