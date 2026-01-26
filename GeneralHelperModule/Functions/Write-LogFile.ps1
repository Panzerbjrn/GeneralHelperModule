function Write-LogFile {
    <#
		.SYNOPSIS
			Writes to a log file

		.DESCRIPTION
			Writes to a log file

		.EXAMPLE
			Write-LogFile

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
