BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-DaysSinceToday' -Tag 'Get-DaysSinceToday', 'Unit' {

  Context 'When calculating days from past dates' {

    It 'Should return positive number for dates in the past' {

      $result = Get-DaysSinceToday -Year 2020 -Month 1 -Day 1
      $result | Should -BeGreaterThan 0
    }

    It 'Should return 0 for today' {

      $today = Get-Date
      $result = Get-DaysSinceToday -Year $today.Year -Month $today.Month -Day $today.Day
      $result | Should -Be 0
    }

  }

  Context 'When calculating days from future dates' {

    It 'Should return negative number for dates in the future' {

      $futureDate = (Get-Date).AddDays(30)
      $result = Get-DaysSinceToday -Year $futureDate.Year -Month $futureDate.Month -Day $futureDate.Day
      $result | Should -BeLessThan 0
      $result | Should -Be -30
    }

  }

  Context 'When calculating specific date ranges' {

    It 'Should correctly calculate days for a known past date' {

      $pastDate = (Get-Date).AddDays(-100)
      $result = Get-DaysSinceToday -Year $pastDate.Year -Month $pastDate.Month -Day $pastDate.Day
      $result | Should -Be 100
    }

  }

}

