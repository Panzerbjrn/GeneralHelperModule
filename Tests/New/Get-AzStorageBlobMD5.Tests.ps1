BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-AzStorageBlobMD5' -Tag 'Get-AzStorageBlobMD5', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Get-AzStorageBlobMD5 -ErrorAction Stop } | Should -Not -Throw
    }

  }

  Context 'When validating parameters' {

    It 'Should require Blob parameter' {

      { Get-AzStorageBlobMD5 -ErrorAction Stop } | Should -Throw
    }

    It 'Should accept Blob parameter of specific type' {

      $param = (Get-Command Get-AzStorageBlobMD5).Parameters['Blob']
      $param.ParameterType.FullName | Should -Be 'Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob'
    }

  }

  Context 'When accepting pipeline input' {

    It 'Should accept Blob from pipeline' {

      $param = (Get-Command Get-AzStorageBlobMD5).Parameters['Blob']
      $param.Attributes.ValueFromPipeline | Should -Contain $true
    }

  }

}

