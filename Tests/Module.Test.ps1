	$ProjectRoot = (Resolve-Path "$PSScriptRoot\..").path
	$ModuleName = Split-Path $ProjectRoot -Leaf
	$ModuleRoot = "$ProjectRoot\$ModuleName\$ModuleName.psm1"
	$ManifestRoot = "$ProjectRoot\$ModuleName\$ModuleName.psd1"
	$Functions = "$ProjectRoot\$ModuleName\Functions"
	$Helpers = "$ProjectRoot\$ModuleName\Helpers"
	Write-Output $Functions
	Get-ChildItem -Path $Functions -Include *.ps1 -Recurse
	Write-Output $Helpers
	Get-ChildItem -Path $Helpers -Include *.ps1 -Recurse


BeforeAll {
	Try{
		Import-module PSScriptAnalyzer -ErrorAction STOP
	}
	Catch{
		Install-Module -Name PSScriptAnalyzer
	}
	IF(!(Get-Module PSScriptAnalyzer)){
		Install-Module -Name PSScriptAnalyzer -Force
	}
	
	$ProjectRoot = (Resolve-Path "$PSScriptRoot\..").path
	$ModuleName = Split-Path $ProjectRoot -Leaf
	$ModuleRoot = "$ProjectRoot\$ModuleName\$ModuleName.psm1"
	$ManifestRoot = "$ProjectRoot\$ModuleName\$ModuleName.psd1"
	$Functions = "$ProjectRoot\$ModuleName\Functions"
	$Helpers = "$ProjectRoot\$ModuleName\Helpers"
	Write-Output $Functions
	Write-Output $Helpers
}

Describe "General project validation: $ModuleName" {
	$Scripts = Get-ChildItem -Path $Functions,$Helpers -Include *.ps1 -Recurse

	# TestCases are splatted to the script
	$TestCase = $Scripts | Foreach-Object {@{file=$_}}
	It "Script <file> should be valid powershell" -TestCases $TestCase {
		param($File)

		$File.Fullname | Should -Exist

		$Contents = Get-Content -Path $File.Fullname -ErrorAction Stop
		$Errors = $null
		$null = [System.Management.Automation.PSParser]::Tokenize($Contents, [ref]$Errors)
		$Errors.Count | Should -Be 0
	}
	It "Script <file> should exist" -TestCases $TestCase {
		param($File)
		Test-Path $File.Fullname | Should -Be $True
	}

	It "Script <file> should have help block" -TestCases $TestCase {
		param($File)
		$File.Fullname | Should -FileContentMatch '<#'
		$File.Fullname | Should -FileContentMatch '#>'
	}

	It "Script <file> should have Synopsis" -TestCases $TestCase {
		param($File)
		$File.Fullname | Should -FileContentMatch '.SYNOPSIS'
	}

	It "Script <file> should have help DESCRIPTION" -TestCases $TestCase {
		param($File)
		$File.Fullname | Should -FileContentMatch 'DESCRIPTION'
	}

	It "Script <file> should have help EXAMPLE" -TestCases $TestCase {
		param($File)
		$File.Fullname | Should -FileContentMatch 'EXAMPLE'
	}

	It "Test-Path $Moduleroot should be True" {
		Test-Path $Moduleroot | Should -Be $True
	}
	
	It "Test-Path $ManifestRoot should be True" {
		Test-Path $ManifestRoot | Should -Be $True
	}

	it 'Passes all default PSScriptAnalyzer rules' {
		Invoke-ScriptAnalyzer -Path $(gci $ModuleRoot).Fullname -ExcludeRule PSUseBOMForUnicodeEncodedFile | should -BeNullOrEmpty
	}

}
