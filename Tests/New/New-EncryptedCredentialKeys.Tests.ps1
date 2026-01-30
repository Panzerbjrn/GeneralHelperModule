BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'New-EncryptedCredentialKey' -Tag 'New-EncryptedCredentialKey', 'Unit' {

  Context 'When creating encrypted credential keys' {

    BeforeAll {

      $testPath = Join-Path $TestDrive "CredKeys"
    }

    AfterAll {

      if (Test-Path $testPath) {
        Remove-Item -Path $testPath -Recurse -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should create credential files without errors' {

      { New-EncryptedCredentialKey -Account "TestUser" -Password "TestP@ss123" -Path $testPath -Confirm:$false } | Should -Not -Throw
    }

    It 'Should create AES.key file' {

      New-EncryptedCredentialKey -Account "TestUser" -Password "TestP@ss123" -Path $testPath -Confirm:$false
      Test-Path (Join-Path $testPath "AES.key") | Should -Be $true
    }

    It 'Should create Password.txt file' {

      New-EncryptedCredentialKey -Account "TestUser2" -Password "TestP@ss456" -Path $testPath -Confirm:$false
      Test-Path (Join-Path $testPath "Password.txt") | Should -Be $true
    }

    It 'Should create Username.txt file' {

      New-EncryptedCredentialKey -Account "TestUser3" -Password "TestP@ss789" -Path $testPath -Confirm:$false
      Test-Path (Join-Path $testPath "Username.txt") | Should -Be $true
    }

  }

  Context 'When using Service parameter' {

    BeforeAll {

      $testPath = Join-Path $TestDrive "ServiceCreds"
    }

    AfterAll {

      if (Test-Path $testPath) {
        Remove-Item -Path $testPath -Recurse -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should create files with service prefix' {

      New-EncryptedCredentialKey -Account "ServiceUser" -Password "ServiceP@ss" -Path $testPath -Service "Azure" -Confirm:$false
      Test-Path (Join-Path $testPath "Azure.AES.key") | Should -Be $true
      Test-Path (Join-Path $testPath "Azure.Password.txt") | Should -Be $true
      Test-Path (Join-Path $testPath "Azure.Username.txt") | Should -Be $true
    }

  }

  Context 'When using aliases' {

    It 'Should have alias New-EncryptedCredentialKeys' {

      $aliases = Get-Alias -Definition New-EncryptedCredentialKey
      $aliases.Name | Should -Contain 'New-EncryptedCredentialKeys'
    }

    It 'Should have alias Create-EncryptedCredentialKeys' {

      $aliases = Get-Alias -Definition New-EncryptedCredentialKey
      $aliases.Name | Should -Contain 'Create-EncryptedCredentialKeys'
    }

  }

  Context 'When using ShouldProcess support' {

    It 'Should support -WhatIf parameter' {

      { New-EncryptedCredentialKey -Account "TestUser" -Password "TestP@ss" -WhatIf } | Should -Not -Throw
    }

    It 'Should support -Confirm parameter' {

      { New-EncryptedCredentialKey -Account "TestUser" -Password "TestP@ss" -Confirm:$false } | Should -Not -Throw
    }

  }

}

