BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Test-JobLoop' -Tag 'Test-JobLoop', 'Unit' {

  Context 'When monitoring a PowerShell job' {

    BeforeAll {

      $script:testJob = Start-Job -ScriptBlock { Start-Sleep -Seconds 2 }
    }

    AfterAll {

      if ($testJob) {
        Remove-Job -Id $testJob.Id -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should accept JobID parameter' {

      { Test-JobLoop -JobID $testJob.Id -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should return job object when complete' {

      $result = Test-JobLoop -JobID $testJob.Id
      $result | Should -Not -BeNullOrEmpty
    }

  }

  Context 'When accepting pipeline input' {

    BeforeAll {

      $script:testJob2 = Start-Job -ScriptBlock { Start-Sleep -Seconds 1 }
    }

    AfterAll {

      if ($testJob2) {
        Remove-Job -Id $testJob2.Id -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should accept JobID from pipeline' {

      { $testJob2.Id | Test-JobLoop } | Should -Not -Throw
    }

  }

}

