BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-RandomHexNumber' -Tag 'Get-RandomHexNumber', 'Unit' {

  Context 'When generating random hex numbers with default parameters' {

    It 'Should generate string of default length (20)' {

      $result = Get-RandomHexNumber
      $result.Length | Should -Be 20
    }

    It 'Should contain only valid hexadecimal characters' {

      $result = Get-RandomHexNumber
      $result | Should -Match '^[0-9A-F]+$'
    }

    It 'Should generate different values on multiple calls' {

      $result1 = Get-RandomHexNumber
      $result2 = Get-RandomHexNumber
      $result1 | Should -Not -Be $result2
    }

  }

  Context 'When generating random hex numbers with custom length' {

    It 'Should generate string of specified length' {

      $result = Get-RandomHexNumber -length 8
      $result.Length | Should -Be 8
    }

    It 'Should generate very short hex numbers' {

      $result = Get-RandomHexNumber -length 1
      $result.Length | Should -Be 1
      $result | Should -Match '^[0-9A-F]$'
    }

    It 'Should generate very long hex numbers' {

      $result = Get-RandomHexNumber -length 100
      $result.Length | Should -Be 100
      $result | Should -Match '^[0-9A-F]+$'
    }

  }

}

