BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-ServerInfo' -Tag 'Get-ServerInfo', 'Unit' {

  Context 'When retrieving server information' {

    It 'Should not throw an error' {

      { Get-ServerInfo -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

    It 'Should return some output' {

      $result = Get-ServerInfo 2>&1
      $result | Should -Not -BeNullOrEmpty
    }

  }

}

