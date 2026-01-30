BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Test-EventLogSource' -Tag 'Test-EventLogSource', 'Unit' {

  Context 'When running as administrator' {

    BeforeAll {

      $isAdmin = Test-IsAdministrator
    }

    It 'Should return boolean for existing source when running as admin' -Skip:(!$isAdmin) {

      $result = Test-EventLogSource -LogName "Application"
      $result | Should -BeOfType [System.Boolean]
    }

    It 'Should return true for known Event Log sources when running as admin' -Skip:(!$isAdmin) {

      $result = Test-EventLogSource -LogName "Application"
      $result | Should -Be $true
    }

  }

  Context 'When running as non-administrator' {

    BeforeAll {

      $isAdmin = Test-IsAdministrator
    }

    It 'Should throw error when not running as administrator' -Skip:($isAdmin) {

      { Test-EventLogSource -LogName "Application" -ErrorAction Stop } | Should -Throw
    }

  }

}

