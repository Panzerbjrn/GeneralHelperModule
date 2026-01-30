BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'New-TempDir' -Tag 'New-TempDir', 'Unit' {

  Context 'When creating temp directory' {

    It 'Should support -WhatIf parameter' {

      { New-TempDir -WhatIf } | Should -Not -Throw
    }

    It 'Should support -Confirm parameter' {

      { New-TempDir -Confirm:$false } | Should -Not -Throw
    }

    It 'Should create C:\Temp if it does not exist' {

      New-TempDir -Confirm:$false
      Test-Path -Path C:\Temp | Should -Be $true
    }

    It 'Should not throw error if C:\Temp already exists' {

      { New-TempDir -Confirm:$false } | Should -Not -Throw
    }

  }

  Context 'When using alias' {

    It 'Should be accessible via Create-TempDir alias' {

      $aliases = Get-Alias -Definition New-TempDir
      $aliases.Name | Should -Contain 'Create-TempDir'
    }

  }

}

