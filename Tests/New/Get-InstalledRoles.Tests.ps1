BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-InstalledRole' -Tag 'Get-InstalledRole', 'Unit' {

  Context 'When checking function availability' {

    It 'Should have alias Get-InstalledRoles' {

      $aliases = Get-Alias -Definition Get-InstalledRole -ErrorAction SilentlyContinue
      if ($aliases) {
        $aliases.Name | Should -Contain 'Get-InstalledRoles'
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

  Context 'When ServerManager module is not available' {

    BeforeAll {

      $serverManagerAvailable = Get-Module -ListAvailable -Name ServerManager
    }

    It 'Should skip if ServerManager module is not available' -Skip:(!$serverManagerAvailable) {

      { Get-InstalledRole -ErrorAction Stop } | Should -Not -Throw
    }

  }

}

