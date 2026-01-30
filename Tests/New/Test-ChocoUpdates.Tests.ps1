BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Test-ChocoUpdate' -Tag 'Test-ChocoUpdate', 'Unit' {

  Context 'When checking function availability' {

    It 'Should have alias Test-ChocoUpdates' {

      $aliases = Get-Alias -Definition Test-ChocoUpdate -ErrorAction SilentlyContinue
      if ($aliases) {
        $aliases.Name | Should -Contain 'Test-ChocoUpdates'
      }
      else {
        Set-ItResult -Skipped -Because "Function or alias not available"
      }
    }

  }

  Context 'When chocolatey is not installed' {

    BeforeAll {

      $chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue
    }

    It 'Should skip test if chocolatey is not installed' -Skip:(!$chocoInstalled) {

      $result = Test-ChocoUpdate -Apps @("git")
      $result | Should -Not -BeNullOrEmpty
    }

  }

}

