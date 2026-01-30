BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Set-PSRepositoryTrust' -Tag 'Set-PSRepositoryTrust', 'Unit' {

  Context 'When setting repository trust' {

    It 'Should support -WhatIf parameter' {

      { Set-PSRepositoryTrust -WhatIf } | Should -Not -Throw
    }

    It 'Should support -Confirm parameter' {

      { Set-PSRepositoryTrust -Confirm:$false -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

  }

  Context 'When using alias Trust-PSRepository' {

    It 'Should be accessible via Trust-PSRepository alias' {

      $aliases = Get-Alias -Definition Set-PSRepositoryTrust
      $aliases.Name | Should -Contain 'Trust-PSRepository'
    }

    It 'Should work with alias and WhatIf' {

      { Trust-PSRepository -WhatIf } | Should -Not -Throw
    }

  }

}

