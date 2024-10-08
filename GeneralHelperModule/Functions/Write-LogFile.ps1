Function Write-LogFile{
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding()]
	param(
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$Message,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$LogFilePath,

		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('Information','Warning','Error')]
		[string]$Severity = 'Information'
	)

	$CaptainsLog = "$(Get-Date -UFormat "%Y.%m.%d_%R") - $($Severity): $Message"
	IF (!(Test-Path $LogFilePath)) {New-Item -ItemType File -Path $LogFilePath -Force}
	
	DO{
		Try{
			Add-Content -Path $LogFilePath -Value $CaptainsLog
			$Done = $True
		}
		Catch{
			$Done = $False
		}
		Finally{
			Start-Sleep -S 1
		}
	}
	While ($Done -ne $True)
}