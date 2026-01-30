BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Add-ToWindowsPath' -Tag 'Add-ToWindowsPath', 'Unit' {

  Context 'When adding path without admin rights' {

    BeforeAll {

      $isAdmin = Test-IsAdministrator
      $testPath = $TestDrive
    }

    It 'Should require administrator privileges' -Skip:($isAdmin) {

      $result = Add-ToWindowsPath -Path $testPath
      $result | Should -Match 'not root'
    }

  }

  Context 'When adding non-existent path' {

    It 'Should throw error for non-existent path' {

      { Add-ToWindowsPath -Path "C:\NonExistentPath123456" -ErrorAction Stop } | Should -Throw
    }

  }

  Context 'When path validation' {

    It 'Should accept valid paths that exist' {

      $validPath = $TestDrive
      { Add-ToWindowsPath -Path $validPath -ErrorAction SilentlyContinue } | Should -Not -Throw
    }

  }

}

