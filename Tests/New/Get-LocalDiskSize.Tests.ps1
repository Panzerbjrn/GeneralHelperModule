BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-LocalDiskSize' -Tag 'Get-LocalDiskSize', 'Unit' {

  Context 'When retrieving local disk information' {

    It 'Should return disk information' {

      $result = Get-LocalDiskSize
      $result | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with SystemName property' {

      $result = Get-LocalDiskSize
      $result[0].SystemName | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with DeviceID property' {

      $result = Get-LocalDiskSize
      $result[0].DeviceID | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with Size property' {

      $result = Get-LocalDiskSize
      $result[0].Size | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with Free property' {

      $result = Get-LocalDiskSize
      $result[0].Free | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with Percent property' {

      $result = Get-LocalDiskSize
      $result[0].Percent | Should -Not -BeNullOrEmpty
    }

    It 'Should return at least one disk' {

      $result = Get-LocalDiskSize
      $result.Count | Should -BeGreaterOrEqual 1
    }

  }

}

