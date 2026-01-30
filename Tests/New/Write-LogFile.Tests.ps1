BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Write-LogFile' -Tag 'Write-LogFile', 'Unit' {

  Context 'When writing log entries with default severity' {

    BeforeAll {

      $logFilePath = Join-Path $TestDrive 'test-default.log'
    }

    AfterAll {

      if (Test-Path $logFilePath) {
        Remove-Item -Path $logFilePath -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should create the log file if it does not exist' {

      Write-LogFile -Message "Test message" -LogFilePath $logFilePath
      Test-Path -Path $logFilePath | Should -Be $true
    }

    It 'Should write Information severity by default' {

      Write-LogFile -Message "Default severity test" -LogFilePath $logFilePath
      $content = Get-Content -Path $logFilePath -Raw
      $content | Should -Match 'Information: Default severity test'
    }

    It 'Should include timestamp in log entry' {

      Write-LogFile -Message "Timestamp test" -LogFilePath $logFilePath
      $content = Get-Content -Path $logFilePath -Raw
      $content | Should -Match '\d{4}\.\d{2}\.\d{2}_\d{2}:\d{2}'
    }

  }

  Context 'When writing log entries with different severity levels' {

    BeforeAll {

      $logFilePath = Join-Path $TestDrive 'test-severity.log'
    }

    AfterAll {

      if (Test-Path $logFilePath) {
        Remove-Item -Path $logFilePath -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should write Warning severity correctly' {

      Write-LogFile -Message "Warning test" -LogFilePath $logFilePath -Severity Warning
      $content = Get-Content -Path $logFilePath -Raw
      $content | Should -Match 'Warning: Warning test'
    }

    It 'Should write Error severity correctly' {

      Write-LogFile -Message "Error test" -LogFilePath $logFilePath -Severity Error
      $content = Get-Content -Path $logFilePath -Raw
      $content | Should -Match 'Error: Error test'
    }

    It 'Should write Information severity correctly' {

      Write-LogFile -Message "Information test" -LogFilePath $logFilePath -Severity Information
      $content = Get-Content -Path $logFilePath -Raw
      $content | Should -Match 'Information: Information test'
    }

  }

  Context 'When appending to existing log file' {

    BeforeAll {

      $logFilePath = Join-Path $TestDrive 'test-append.log'
    }

    AfterAll {

      if (Test-Path $logFilePath) {
        Remove-Item -Path $logFilePath -Force -ErrorAction SilentlyContinue
      }
    }

    It 'Should append multiple entries to the same file' {

      Write-LogFile -Message "First entry" -LogFilePath $logFilePath
      Write-LogFile -Message "Second entry" -LogFilePath $logFilePath
      Write-LogFile -Message "Third entry" -LogFilePath $logFilePath

      $content = Get-Content -Path $logFilePath
      $content.Count | Should -BeGreaterOrEqual 3
      $content -join ' ' | Should -Match 'First entry'
      $content -join ' ' | Should -Match 'Second entry'
      $content -join ' ' | Should -Match 'Third entry'
    }

  }

}

