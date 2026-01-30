BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-RemoteDisk' -Tag 'Get-RemoteDisk', 'Unit' {

  Context 'When retrieving remote disk information' {

    It 'Should accept Name parameter' {

      { Get-RemoteDisk -Name "localhost" -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

    It 'Should have alias Get-RemoteDisks' {

      $aliases = Get-Alias -Definition Get-RemoteDisk
      $aliases.Name | Should -Contain 'Get-RemoteDisks'
    }

  }

  Context 'When querying local machine as remote' {

    It 'Should return disk information for localhost' {

      $result = Get-RemoteDisk -Name $env:COMPUTERNAME
      $result | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with SystemName property' {

      $result = Get-RemoteDisk -Name $env:COMPUTERNAME
      $result[0].SystemName | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with DeviceID property' {

      $result = Get-RemoteDisk -Name $env:COMPUTERNAME
      $result[0].DeviceID | Should -Not -BeNullOrEmpty
    }

  }

}

