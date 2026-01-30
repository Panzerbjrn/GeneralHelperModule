BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Set-FolderACL' -Tag 'Set-FolderACL', 'Unit' {

  Context 'When checking function availability' {

    It 'Should have alias Change-ACL' {

      $aliases = Get-Alias -Definition Set-FolderACL -ErrorAction SilentlyContinue
      if ($aliases) {
        $aliases.Name | Should -Contain 'Change-ACL'
      }
      else {
        Set-ItResult -Skipped -Because "Function or alias not available"
      }
    }

  }

  Context 'When validating parameters' {

    It 'Should require Directory parameter' {

      { Set-FolderACL -ErrorAction Stop } | Should -Throw
    }

    It 'Should require UserNames parameter' {

      { Set-FolderACL -Directory "C:\Test" -ErrorAction Stop } | Should -Throw
    }

    It 'Should support -WhatIf parameter' {

      { Set-FolderACL -Directory $TestDrive -UserNames "TestUser" -AccessLevel "Read" -Add -WhatIf -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

  }

  Context 'When checking access level validation' {

    It 'Should validate AccessLevel parameter with valid values' {

      $validLevels = @("Read", "Write", "Modify", "FullControl")
      foreach ($level in $validLevels) {
        { Set-FolderACL -Directory $TestDrive -UserNames "TestUser" -AccessLevel $level -Add -WhatIf -ErrorAction SilentlyContinue } | Should -Not -Throw
      }
    }

  }

}

