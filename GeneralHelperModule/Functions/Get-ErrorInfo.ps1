Function Get-ErrorInfo {
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

		.NOTES
			## http://community.idera.com/powershell/powertips/b/tips/posts/demystifying-error-handling
	#>
	[CmdletBinding()]
	param(
		[Parameter(ValueFrompipeline)]
		[Management.Automation.ErrorRecord]$ErrorRecord
	)
	process{
		$Info = [PSCustomObject]@{
		Exception = $ErrorRecord.Exception.Message
		Testing = $ErrorRecord.Exception.Message
		Reason= $ErrorRecord.CategoryInfo.Reason
		Fullname= $ErrorRecord.exception.GetType().fullname
		Target= $ErrorRecord.CategoryInfo.TargetName
		Script= $ErrorRecord.InvocationInfo.ScriptName
		Line= $ErrorRecord.InvocationInfo.ScriptLineNumber
		Column= $ErrorRecord.InvocationInfo.OffsetInLine
		Date= Get-Date
		User= $env:username
		}

	$Info
	}
}