BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Set-ConsoleConfig' -Tag 'Set-ConsoleConfig', 'Unit' {

  Context 'When setting custom console title' {

    It 'Should not throw an error with custom title' {

      { Set-ConsoleConfig -Title "Test Title" -Confirm:$false } | Should -Not -Throw
    }

    It 'Should support -WhatIf parameter' {

      { Set-ConsoleConfig -Title "Test Title" -WhatIf } | Should -Not -Throw
    }

    It 'Should support -Confirm parameter' {

      { Set-ConsoleConfig -Title "Test Title" -Confirm:$false } | Should -Not -Throw
    }

  }

  Context 'When using AdminCheck parameter' {

    It 'Should not throw an error with AdminCheck switch' {

      { Set-ConsoleConfig -AdminCheck -Confirm:$false } | Should -Not -Throw
    }

    It 'Should support -WhatIf with AdminCheck' {

      { Set-ConsoleConfig -AdminCheck -WhatIf } | Should -Not -Throw
    }

  }

}

