BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-PSVersion' -Tag 'Get-PSVersion', 'Unit' {

  Context 'When retrieving PowerShell version information' {

    It 'Should not throw an error' {

      { Get-PSVersion } | Should -Not -Throw
    }

    It 'Should return output' {

      $result = Get-PSVersion
      $result | Should -Not -BeNullOrEmpty
    }

  }

}

