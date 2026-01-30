BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Enable-RDPAccess' -Tag 'Enable-RDPAccess', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Enable-RDPAccess -ErrorAction Stop } | Should -Not -Throw
    }

  }

  Context 'When validating requirements' {

    BeforeAll {

      $isAdmin = Test-IsAdministrator
    }

    It 'Should require administrator privileges to execute' -Skip:(!$isAdmin) {

      { Enable-RDPAccess -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should skip if not running as administrator' -Skip:($isAdmin) {

      Set-ItResult -Skipped -Because "Requires administrator privileges"
    }

  }

}

