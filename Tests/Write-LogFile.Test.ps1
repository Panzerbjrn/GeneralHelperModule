Describe "Write-LogFile Test" {
    $logFilePath = (Join-Path $TestDrive 'File.txt')

    # Test if the Function Creates the file
    It "Creates the log file if it doesn't exist" {
        Remove-Item -Path $logFilePath -Force -ErrorAction SilentlyContinue
        Write-LogFile -Message "Test message" -LogFilePath $logFilePath
        (Test-Path -Path $logFilePath) | Should -Be $true
    }

    # Test if the log entry is written to the file
    It "Writes the correct log entry to the file" {
        Remove-Item -Path $logFilePath -Force -ErrorAction SilentlyContinue
        Write-LogFile -Message "Test message" -LogFilePath $logFilePath
        $logContent = Get-Content -Path $logFilePath
        $expectedPattern = "\d{4}\.\d{2}\.\d{2}_\d{2}:\d{2} - Information: Test message"
        $logContent | Should -Match $expectedPattern
    }

    # Test if the correct severity level is logged
    It "Logs the correct severity level" {
        Remove-Item -Path $logFilePath -Force -ErrorAction SilentlyContinue
        Write-LogFile -Message "Test message" -LogFilePath $logFilePath -Severity "Warning"
        $logContent = Get-Content -Path $logFilePath
        $expectedPattern = "\d{4}\.\d{2}\.\d{2}_\d{2}:\d{2} - Warning: Test message"
        $logContent | Should -Match $expectedPattern
    }
}

