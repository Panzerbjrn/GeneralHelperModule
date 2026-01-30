BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Add-NewModuleStructure' -Tag 'Add-NewModuleStructure', 'Unit' {

  Context 'When checking function availability' {

    It 'Should not throw parsing errors' {

      { Get-Command Add-NewModuleStructure -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should have alias Create-NewModuleStructure' {

      $aliases = Get-Alias -Definition Add-NewModuleStructure
      $aliases.Name | Should -Contain 'Create-NewModuleStructure'
    }

  }

  Context 'When validating parameters' {

    It 'Should require ModuleName parameter' {

      { Add-NewModuleStructure -ErrorAction Stop } | Should -Throw
    }

    It 'Should have default Author parameter' {

      $param = (Get-Command Add-NewModuleStructure).Parameters['Author']
      $param.Attributes.Mandatory | Should -Not -Contain $true
    }

    It 'Should have default Path parameter' {

      $param = (Get-Command Add-NewModuleStructure).Parameters['Path']
      $param.Attributes.Mandatory | Should -Not -Contain $true
    }

  }

  Context 'When creating module structure' {

    BeforeAll {

      $testModuleName = "TestModule_$(Get-Random)"
      $testModulePath = Join-Path $TestDrive $testModuleName
    }

    AfterAll {

      if (Test-Path $testModulePath) {
        Remove-Item -Path $testModulePath -Recurse -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should create module directory structure' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path $testModulePath | Should -Be $true
    }

    It 'Should create Functions folder' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "Functions") | Should -Be $true
    }

    It 'Should create Helpers folder' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "Helpers") | Should -Be $true
    }

    It 'Should create Tests folder' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "Tests") | Should -Be $true
    }

    It 'Should create WIP folder' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "WIP") | Should -Be $true
    }

    It 'Should create module manifest file' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "$testModuleName.psd1") | Should -Be $true
    }

    It 'Should create module file' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "$testModuleName.psm1") | Should -Be $true
    }

    It 'Should create en-GB help folder' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "en-GB") | Should -Be $true
    }

    It 'Should create about help file' {

      Add-NewModuleStructure -ModuleName $testModuleName -Path $TestDrive -ErrorAction Stop
      Test-Path (Join-Path $testModulePath "en-GB\about_$testModuleName.help.txt") | Should -Be $true
    }

  }

}

