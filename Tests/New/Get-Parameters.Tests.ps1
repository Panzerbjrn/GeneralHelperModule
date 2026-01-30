BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-Parameter' -Tag 'Get-Parameter', 'Unit' {

  Context 'When retrieving parameter information for commands' {

    It 'Should return parameter information for Get-Process' {

      $result = Get-Parameter -CommandName "Get-Process"
      $result | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with Name property' {

      $result = Get-Parameter -CommandName "Get-Process"
      $result[0].Name | Should -Not -BeNullOrEmpty
    }

    It 'Should return objects with Mandatory property' {

      $result = Get-Parameter -CommandName "Get-Process"
      $result[0].PSObject.Properties.Name | Should -Contain 'Mandatory'
    }

    It 'Should return multiple parameters for a command' {

      $result = Get-Parameter -CommandName "Get-Process"
      $result.Count | Should -BeGreaterThan 1
    }

    It 'Should identify mandatory parameters correctly' {

      $result = Get-Parameter -CommandName "Get-DataTypeName"
      $mandatoryParam = $result | Where-Object { $_.Name -eq 'Value' }
      $mandatoryParam.Mandatory | Should -Contain $true
    }

  }

  Context 'When using alias Get-Parameters' {

    It 'Should be accessible via Get-Parameters alias' {

      $aliases = Get-Alias -Definition Get-Parameter
      $aliases.Name | Should -Contain 'Get-Parameters'
    }

    It 'Should work with alias' {

      $result = Get-Parameters -CommandName "Get-Process"
      $result | Should -Not -BeNullOrEmpty
    }

  }

}

