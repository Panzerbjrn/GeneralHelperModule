BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'New-RandomPassword' -Tag 'New-RandomPassword', 'Unit' {

  Context 'When generating passwords with default length' {

    It 'Should generate password of default length (15)' {

      $result = New-RandomPassword -Confirm:$false
      $result.Length | Should -Be 15
    }

    It 'Should return a string' {

      $result = New-RandomPassword -Confirm:$false
      $result | Should -BeOfType [System.String]
    }

    It 'Should generate different passwords on multiple calls' {

      $password1 = New-RandomPassword -Confirm:$false
      $password2 = New-RandomPassword -Confirm:$false
      $password1 | Should -Not -Be $password2
    }

  }

  Context 'When generating passwords with custom length' {

    It 'Should generate password of specified length' {

      $result = New-RandomPassword -Length 20 -Confirm:$false
      $result.Length | Should -Be 20
    }

    It 'Should generate short passwords' {

      $result = New-RandomPassword -Length 8 -Confirm:$false
      $result.Length | Should -Be 8
    }

    It 'Should generate long passwords' {

      $result = New-RandomPassword -Length 50 -Confirm:$false
      $result.Length | Should -Be 50
    }

  }

  Context 'When checking password character composition' {

    It 'Should contain alphanumeric characters' {

      $result = New-RandomPassword -Length 30 -Confirm:$false
      $result | Should -Match '[A-Za-z0-9]'
    }

  }

  Context 'When using alias Random-Password' {

    It 'Should be accessible via Random-Password alias' {

      $aliases = Get-Alias -Definition New-RandomPassword
      $aliases.Name | Should -Contain 'Random-Password'
    }

    It 'Should work with alias' {

      $result = Random-Password -Length 12 -Confirm:$false
      $result.Length | Should -Be 12
    }

  }

  Context 'When using ShouldProcess support' {

    It 'Should support -WhatIf parameter' {

      { New-RandomPassword -WhatIf } | Should -Not -Throw
    }

    It 'Should support -Confirm parameter' {

      { New-RandomPassword -Confirm:$false } | Should -Not -Throw
    }

  }

}

