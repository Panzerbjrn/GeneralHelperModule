Function Write-LogFile {
    <#
		.SYNOPSIS
			Writes timestamped messages to a log file

		.DESCRIPTION
			This function writes timestamped log messages to a specified file with severity levels (Information, Warning, Error).
			If no log file path is provided, it automatically creates one in C:\Temp with the calling function's name.

		.PARAMETER Message
			The message to write to the log file

		.PARAMETER LogFilePath
			The full path to the log file. If not specified, creates a log file in C:\Temp named after the calling function

		.PARAMETER Severity
			The severity level of the message. Valid values are 'Information', 'Warning', or 'Error'. Default is 'Information'

		.EXAMPLE
			Write-LogFile -Message "Process completed successfully"

			Writes an informational message to the default log file location

		.EXAMPLE
			Write-LogFile -Message "Configuration file not found" -Severity Warning -LogFilePath "C:\Logs\MyApp.log"

			Writes a warning message to a specific log file

		.EXAMPLE
			Write-LogFile -Message "Failed to connect to database" -Severity Error

			Writes an error message to the default log file location

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [Parameter()]
        [string]$LogFilePath,

        [Parameter()]
        [ValidateSet('Information', 'Warning', 'Error')]
        [string]$Severity = 'Information'
    )

    $CaptainsLog = "$(Get-Date -UFormat "%Y.%m.%d_%R") - $($Severity): $Message"
    if ( -not $PSBoundParameters.ContainsKey('LogFilePath') ) {
        [string]$CallingFunction = $((Get-PSCallStack)[2].Command) #Going up 2 to capture the right command
        $Path = 'C:\Temp'
        $Filename = "$(Get-Date -Format 'yyyy-MM-dd HH')xx - $CallingFunction - ERROR.log"
        $LogFilePath = Join-Path "$Path" "$Filename"
    }

    if (!(Test-Path $LogFilePath)) { New-Item -ItemType File -Path $LogFilePath -Force }

    do {
        try {
            Write-Verbose $CaptainsLog
            Add-Content -Path $LogFilePath -Value $CaptainsLog
            $Done = $True
        }
        catch {
            $Done = $False
        }
        finally {
            Start-Sleep -Milliseconds 250
        }
    }
    while ($Done -ne $True)
}

