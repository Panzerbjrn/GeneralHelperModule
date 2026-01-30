BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Convert-ExcelToCSV' -Tag 'Convert-ExcelToCSV', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Convert-ExcelToCSV -ErrorAction Stop } | Should -Not -Throw
    }

  }

  Context 'When validating parameters' {

    It 'Should require Path parameter' {

      { Convert-ExcelToCSV -ErrorAction Stop } | Should -Throw
    }

    It 'Should require ExcelFileName parameter' {

      { Convert-ExcelToCSV -Path "C:\Test" -ErrorAction Stop } | Should -Throw
    }

    It 'Should require CSVLoc parameter' {

      { Convert-ExcelToCSV -Path "C:\Test" -ExcelFileName "test.xlsx" -ErrorAction Stop } | Should -Throw
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

