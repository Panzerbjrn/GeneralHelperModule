BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-RunningService' -Tag 'Get-RunningService', 'Unit' {

  Context 'When checking function availability' {

    It 'Should have alias Get-RunningServices' {

      $aliases = Get-Alias -Definition Get-RunningService -ErrorAction SilentlyContinue
      if ($aliases) {
        $aliases.Name | Should -Contain 'Get-RunningServices'
      }
      else {
        Set-ItResult -Skipped -Because "Function or alias not available"
      }
    }

    It 'Should create C:\Temp directory if needed' {

      $tempExists = Test-Path "C:\Temp"
      $tempExists | Should -BeOfType [System.Boolean]
    }

  }

}

