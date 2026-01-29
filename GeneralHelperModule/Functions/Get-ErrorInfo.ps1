Function Get-ErrorInfo {
    <#
		.SYNOPSIS
			Extracts detailed information from PowerShell error records

		.DESCRIPTION
			This function parses ErrorRecord objects and returns structured information including exception message, reason, target, script location, and user context.
			Useful for error logging and debugging.

		.PARAMETER ErrorRecord
			The ErrorRecord object to parse. Accepts pipeline input

		.EXAMPLE
			Get-ErrorInfo -ErrorRecord $Error[0]

			Extracts detailed information from the most recent error

		.EXAMPLE
			try { Get-Item "C:\NonExistent" } catch { $_ | Get-ErrorInfo }

			Captures and parses error information from a try-catch block

		.NOTES
			Based on techniques from http://community.idera.com/powershell/powertips/b/tips/posts/demystifying-error-handling

	#>
    [CmdletBinding()]
    param(
        [Parameter(ValueFrompipeline)]
        [Management.Automation.ErrorRecord]$ErrorRecord
    )
    PROCESS {
        $Info = [PSCustomObject]@{
            Exception = $ErrorRecord.Exception.Message
            Testing   = $ErrorRecord.Exception.Message
            Reason    = $ErrorRecord.CategoryInfo.Reason
            Fullname  = $ErrorRecord.exception.GetType().fullname
            Target    = $ErrorRecord.CategoryInfo.TargetName
            Script    = $ErrorRecord.InvocationInfo.ScriptName
            Line      = $ErrorRecord.InvocationInfo.ScriptLineNumber
            Column    = $ErrorRecord.InvocationInfo.OffsetInLine
            Date      = Get-Date
            User      = $env:username
        }

        $Info
    }
}

