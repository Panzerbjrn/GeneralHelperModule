BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Set-Prompt' -Tag 'Set-Prompt', 'Unit' {

  Context 'When setting custom prompt' {

    It 'Should not throw an error' {

      { Set-Prompt -Confirm:$false } | Should -Not -Throw
    }

    It 'Should return a string' {

      $result = Set-Prompt -Confirm:$false
      $result | Should -BeOfType [System.String]
    }

    It 'Should contain username in prompt' {

      $result = Set-Prompt -Confirm:$false
      $result | Should -Match $env:USERNAME.ToLower()
    }

    It 'Should contain computername in prompt' {

      $result = Set-Prompt -Confirm:$false
      $result | Should -Match $env:COMPUTERNAME.ToLower()
    }

    It 'Should end with $ or # symbol' {

      $result = Set-Prompt -Confirm:$false
      $result | Should -Match '[\$#]\s$'
    }

  }

  Context 'When using ShouldProcess support' {

    It 'Should support -WhatIf parameter' {

      { Set-Prompt -WhatIf } | Should -Not -Throw
    }

    It 'Should support -Confirm parameter' {

      { Set-Prompt -Confirm:$false } | Should -Not -Throw
    }

  }

}

