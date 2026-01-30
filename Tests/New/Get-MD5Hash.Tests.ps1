BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-MD5Hash' -Tag 'Get-MD5Hash', 'Unit' {

  Context 'When calculating MD5 hash of existing files' {

    BeforeAll {

      $testFile = Join-Path $TestDrive 'test-hash.txt'
      'Test content for MD5 hash' | Out-File -FilePath $testFile -Encoding ASCII
    }

    AfterAll {

      if (Test-Path $testFile) {
        Remove-Item -Path $testFile -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should return a Base64-encoded string' {

      $result = Get-MD5Hash -Path $testFile
      $result | Should -Not -BeNullOrEmpty
      $result | Should -BeOfType [System.String]
    }

    It 'Should return the same hash for the same file content' {

      $hash1 = Get-MD5Hash -Path $testFile
      $hash2 = Get-MD5Hash -Path $testFile
      $hash1 | Should -Be $hash2
    }

    It 'Should return different hashes for different content' {

      $testFile2 = Join-Path $TestDrive 'test-hash2.txt'
      'Different content' | Out-File -FilePath $testFile2 -Encoding ASCII

      $hash1 = Get-MD5Hash -Path $testFile
      $hash2 = Get-MD5Hash -Path $testFile2
      $hash1 | Should -Not -Be $hash2

      Remove-Item -Path $testFile2 -Force -ErrorAction SilentlyContinue
    }

  }

  Context 'When calculating MD5 hash of non-existing files' {

    It 'Should return null for non-existent file' {

      $result = Get-MD5Hash -Path "C:\NonExistent\File.txt"
      $result | Should -BeNullOrEmpty
    }

  }

}

