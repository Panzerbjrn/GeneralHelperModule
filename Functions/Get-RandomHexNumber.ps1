Function Get-RandomHexNumber {
<#
	.SYNOPSIS
		This will generate a random Hex number. Either based on length or bits

	.DESCRIPTION
		This will generate a random Hex number. Either based on length or bits

	.PARAMETER Length
		This is the length of the resulting number

	.PARAMETER Bits
		This is the length of the resulting number in bits.

	.EXAMPLE
		Create-NewModuleStructure -Path C:\Temp\ -ModuleName Test-Module -Author LarsP -Description "Test PowerShell Module"

	.EXAMPLE
		Create-NewModuleStructure -ModuleName ServiceNowCMDB -Path C:\Temp -Description "Helper Functions to work with ServiceNow's CMDB"

	.INPUTS
		A number

	.OUTPUTS
		A Hex number

	.NOTES
		Version:			1.0
		Author:			Lars Panzerbjrn
		Creation Date:	2019.08.10
		Purpose/Change: Initial script development
		
#>
    param( 
        [int] $length = 20,
        [string] $chars = "0123456789ABCDEF"
    )
		#IF ("Length" -eq $PSCmdlet.ParameterSetName)
		#{
			$bytes = new-object "System.Byte[]" $length
			$rnd = new-object System.Security.Cryptography.RNGCryptoServiceProvider
			$rnd.GetBytes($bytes)
			$result = ""
			1..$length | foreach-object{
				$result += $chars[ $bytes[$_] % $chars.Length ]	
			}
				$result
		#}
}