BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Test-PendingReboot' -Tag 'Test-PendingReboot', 'Unit' {

  Context 'When checking for pending reboot' {

    It 'Should return a boolean value' {

      $result = Test-PendingReboot
      $result | Should -BeOfType [System.Boolean]
    }

    It 'Should not throw an error' {

      { Test-PendingReboot } | Should -Not -Throw
    }

    It 'Should return consistent results on multiple calls' {

      $result1 = Test-PendingReboot
      $result2 = Test-PendingReboot
      $result1 | Should -Be $result2
    }

  }

}

