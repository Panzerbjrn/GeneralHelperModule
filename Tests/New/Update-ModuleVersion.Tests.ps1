BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Update-ModuleVersion' -Tag 'Update-ModuleVersion', 'Unit' {

  Context 'When validating parameters' {

    It 'Should require ModulePath parameter' {

      { Update-ModuleVersion -ErrorAction Stop } | Should -Throw
    }

    It 'Should support -WhatIf parameter' {

      $testModule = Join-Path $TestDrive "TestModule"
      New-Item -ItemType Directory -Path $testModule -Force | Out-Null

      { Update-ModuleVersion -ModulePath $testModule -WhatIf -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

    It 'Should support -Ask switch' {

      $testModule = Join-Path $TestDrive "TestModule"
      New-Item -ItemType Directory -Path $testModule -Force | Out-Null

      { Update-ModuleVersion -ModulePath $testModule -Ask -Confirm:$false -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

    It 'Should support -Patch switch' {

      $testModule = Join-Path $TestDrive "TestModule"
      New-Item -ItemType Directory -Path $testModule -Force | Out-Null

      { Update-ModuleVersion -ModulePath $testModule -Patch -WhatIf -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

  }

  Context 'When checking ShouldProcess support' {

    It 'Should support -Confirm parameter' {

      $testModule = Join-Path $TestDrive "TestModule"
      New-Item -ItemType Directory -Path $testModule -Force | Out-Null

      { Update-ModuleVersion -ModulePath $testModule -Confirm:$false -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

  }

}

