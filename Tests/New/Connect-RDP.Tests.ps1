BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Connect-RDP' -Tag 'Connect-RDP', 'Unit' {

  Context 'When validating parameters' {

    It 'Should require Server parameter' {

      { Connect-RDP -ErrorAction Stop } | Should -Throw
    }

    It 'Should accept Server parameter' {

      { Connect-RDP -Server "testserver" -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

  }

}

