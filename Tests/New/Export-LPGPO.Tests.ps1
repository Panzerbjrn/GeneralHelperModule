BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Export-GPOReport' -Tag 'Export-GPOReport', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Export-GPOReport -ErrorAction Stop } | Should -Not -Throw
    }

  }

  Context 'When GroupPolicy module is available' {

    BeforeAll {

      $groupPolicyAvailable = Get-Module -ListAvailable -Name GroupPolicy
    }

    It 'Should skip if GroupPolicy module is not available' -Skip:(!$groupPolicyAvailable) {

      { Export-GPOReport -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should indicate when GroupPolicy module is not available' -Skip:($groupPolicyAvailable) {

      Set-ItResult -Skipped -Because "GroupPolicy module is not available on this system"
    }

  }

}

