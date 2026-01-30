BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-LastReboot' -Tag 'Get-LastReboot', 'Unit' {

  Context 'When retrieving last reboot information for local machine' {

    It 'Should return reboot information for local machine' {

      $result = Get-LastReboot
      $result | Should -Not -BeNullOrEmpty
    }

    It 'Should return object with ComputerName property' {

      $result = Get-LastReboot
      $result.ComputerName | Should -Not -BeNullOrEmpty
    }

    It 'Should return object with LastBoot property' {

      $result = Get-LastReboot
      $result.LastBoot | Should -BeOfType [System.DateTime]
    }

    It 'Should return object with UpTime property' {

      $result = Get-LastReboot
      $result.UpTime | Should -BeOfType [System.TimeSpan]
    }

    It 'Should return object with CleanBoot property' {

      $result = Get-LastReboot
      $result.CleanBoot | Should -BeOfType [System.Boolean]
    }

    It 'Should have positive uptime' {

      $result = Get-LastReboot
      $result.UpTime.TotalSeconds | Should -BeGreaterThan 0
    }

  }

  Context 'When using pipeline input' {

    It 'Should accept computer name from pipeline' {

      $result = $env:ComputerName | Get-LastReboot
      $result | Should -Not -BeNullOrEmpty
    }

  }

}

