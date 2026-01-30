BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Test-IsAdministrator' -Tag 'Test-IsAdministrator', 'Unit' {

  Context 'When checking administrator status' {

    It 'Should return a boolean value' {

      $result = Test-IsAdministrator
      $result | Should -BeOfType [System.Boolean]
    }

    It 'Should not throw an error' {

      { Test-IsAdministrator } | Should -Not -Throw
    }

    It 'Should return consistent results on multiple calls' {

      $result1 = Test-IsAdministrator
      $result2 = Test-IsAdministrator
      $result1 | Should -Be $result2
    }

  }

}

