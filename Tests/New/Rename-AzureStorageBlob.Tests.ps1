BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Rename-AzureStorageBlob' -Tag 'Rename-AzureStorageBlob', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Rename-AzureStorageBlob -ErrorAction Stop } | Should -Not -Throw
    }

  }

  Context 'When validating parameters' {

    It 'Should require Blob parameter' {

      { Rename-AzureStorageBlob -ErrorAction Stop } | Should -Throw
    }

    It 'Should require NewName parameter' {

      { Rename-AzureStorageBlob -NewName "test.txt" -ErrorAction Stop } | Should -Throw
    }

  }

  Context 'When using ShouldProcess support' {

    It 'Should support -WhatIf parameter' {

      Get-Command Rename-AzureStorageBlob | Select-Object -ExpandProperty Parameters | Where-Object { $_.Keys -contains 'WhatIf' } | Should -Not -BeNullOrEmpty
    }

    It 'Should support -Confirm parameter' {

      Get-Command Rename-AzureStorageBlob | Select-Object -ExpandProperty Parameters | Where-Object { $_.Keys -contains 'Confirm' } | Should -Not -BeNullOrEmpty
    }

  }

}

