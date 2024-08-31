Function Convert-ArrayToHash($a){
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
	[CmdletBinding()]
    $Hash = @{}
    ($a | Get-Member | Where-Object {$_.Membertype -eq "NoteProperty"}).name | ForEach-Object {$Hash.$($_) = $A.$($_)}
	$hash
}