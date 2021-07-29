Describe "Write-Logfile Test" {
	
	IT "Test if File.txt exist" {
		(test-path -path (Join-Path $TestDrive 'File.txt')	) | Should -Be $true
	}
}