BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'ConvertFrom-UnixTimestamp' -Tag 'ConvertFrom-UnixTimestamp', 'Unit' {

  Context 'When converting Unix timestamps in seconds' {

    It 'Should convert epoch (0) to January 1, 1970' {

      $result = ConvertFrom-UnixTimestamp -Seconds 0
      $result.Year | Should -Be 1970
      $result.Month | Should -Be 1
      $result.Day | Should -Be 1
    }

    It 'Should return a DateTime object' {

      $result = ConvertFrom-UnixTimestamp -Seconds 1609459200
      $result | Should -BeOfType [System.DateTime]
    }

    It 'Should convert known timestamp correctly (2021-01-01)' {

      $result = ConvertFrom-UnixTimestamp -Seconds 1609459200
      $result.Year | Should -Be 2021
      $result.Month | Should -Be 1
      $result.Day | Should -Be 1
    }

  }

  Context 'When converting Unix timestamps in milliseconds' {

    It 'Should convert epoch (0) to January 1, 1970' {

      $result = ConvertFrom-UnixTimestamp -Milliseconds 0
      $result.Year | Should -Be 1970
      $result.Month | Should -Be 1
      $result.Day | Should -Be 1
    }

    It 'Should return a DateTime object' {

      $result = ConvertFrom-UnixTimestamp -Milliseconds 1609459200000
      $result | Should -BeOfType [System.DateTime]
    }

    It 'Should convert known timestamp correctly (2021-01-01)' {

      $result = ConvertFrom-UnixTimestamp -Milliseconds 1609459200000
      $result.Year | Should -Be 2021
      $result.Month | Should -Be 1
      $result.Day | Should -Be 1
    }

  }

}

