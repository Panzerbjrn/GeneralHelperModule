BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-RandomString' -Tag 'Get-RandomString', 'Unit' {

  Context 'When generating hexadecimal strings' {

    It 'Should generate string of correct length' {

      $result = Get-RandomString -NumberOfCharacters 8 -Hexidecimal
      $result.Length | Should -Be 8
    }

    It 'Should contain only valid hexadecimal characters' {

      $result = Get-RandomString -NumberOfCharacters 10 -Hexidecimal
      $result | Should -Match '^[0-9A-H]+$'
    }

    It 'Should generate default 3 characters when length not specified' {

      $result = Get-RandomString -Hexidecimal
      $result.Length | Should -Be 3
    }

    It 'Should generate different strings on multiple calls' {

      $result1 = Get-RandomString -NumberOfCharacters 20 -Hexidecimal
      $result2 = Get-RandomString -NumberOfCharacters 20 -Hexidecimal
      $result1 | Should -Not -Be $result2
    }

  }

  Context 'When generating decimal strings' {

    It 'Should generate string of correct length' {

      $result = Get-RandomString -NumberOfCharacters 6 -Decimal
      $result.Length | Should -Be 6
    }

    It 'Should contain only numeric characters' {

      $result = Get-RandomString -NumberOfCharacters 10 -Decimal
      $result | Should -Match '^[0-9]+$'
    }

    It 'Should generate default 3 characters when length not specified' {

      $result = Get-RandomString -Decimal
      $result.Length | Should -Be 3
    }

  }

  Context 'When generating alphanumeric strings' {

    It 'Should generate string of correct length' {

      $result = Get-RandomString -NumberOfCharacters 12 -AlphaNumeric
      $result.Length | Should -Be 12
    }

    It 'Should contain only alphanumeric characters' {

      $result = Get-RandomString -NumberOfCharacters 15 -AlphaNumeric
      $result | Should -Match '^[0-9A-Za-z]+$'
    }

    It 'Should generate default 3 characters when length not specified' {

      $result = Get-RandomString -AlphaNumeric
      $result.Length | Should -Be 3
    }

    It 'Should be case-sensitive and include both upper and lowercase' {

      # Generate enough strings to statistically have both cases
      $results = 1..20 | ForEach-Object { Get-RandomString -NumberOfCharacters 20 -AlphaNumeric }
      $combined = $results -join ''
      $combined | Should -Match '[a-z]'
      $combined | Should -Match '[A-Z]'
    }

  }

}

