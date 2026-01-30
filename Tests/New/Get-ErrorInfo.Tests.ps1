BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-ErrorInfo' -Tag 'Get-ErrorInfo', 'Unit' {

  Context 'When parsing error records' {

    BeforeAll {

      try {
        Get-Item "C:\NonExistent\TestFile.txt" -ErrorAction Stop
      }
      catch {
        $script:testError = $_
      }
    }

    It 'Should return a PSCustomObject' {

      $result = Get-ErrorInfo -ErrorRecord $testError
      $result | Should -BeOfType [PSCustomObject]
    }

    It 'Should contain Exception property' {

      $result = Get-ErrorInfo -ErrorRecord $testError
      $result.Exception | Should -Not -BeNullOrEmpty
    }

    It 'Should contain Reason property' {

      $result = Get-ErrorInfo -ErrorRecord $testError
      $result.Reason | Should -Not -BeNullOrEmpty
    }

    It 'Should contain Fullname property' {

      $result = Get-ErrorInfo -ErrorRecord $testError
      $result.Fullname | Should -Not -BeNullOrEmpty
    }

    It 'Should contain Date property with DateTime type' {

      $result = Get-ErrorInfo -ErrorRecord $testError
      $result.Date | Should -BeOfType [System.DateTime]
    }

    It 'Should contain User property' {

      $result = Get-ErrorInfo -ErrorRecord $testError
      $result.User | Should -Be $env:username
    }

  }

  Context 'When accepting pipeline input' {

    It 'Should accept ErrorRecord from pipeline' {

      try {
        Get-Item "C:\NonExistent\File.txt" -ErrorAction Stop
      }
      catch {
        $result = $_ | Get-ErrorInfo
        $result | Should -Not -BeNullOrEmpty
      }
    }

  }

}

