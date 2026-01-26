function Get-RandomHexNumber {
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


	.EXAMPLE


	.INPUTS
		A number

	.OUTPUTS
		A Hex number

	.NOTES
		Version:			1.0
		Author:			Lars Panzerbjrn
		Creation Date:	2019.08.10
#>
    param(
        [int] $length = 20,
        [string] $chars = "0123456789ABCDEF"
    )
    #IF ("Length" -eq $PSCmdlet.ParameterSetName)
    #{
    $bytes = New-Object "System.Byte[]" $length
    $rnd = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $rnd.GetBytes($bytes)
    $result = ""
    1..$length | ForEach-Object {
        $result += $chars[ $bytes[$_] % $chars.Length ]
    }
				$result
    #}
}

