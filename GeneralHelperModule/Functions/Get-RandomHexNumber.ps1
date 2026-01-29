Function Get-RandomHexNumber {
    <#
		.SYNOPSIS
			Generates a random hexadecimal number

		.DESCRIPTION
			This function generates a cryptographically random hexadecimal number of specified length using the RNGCryptoServiceProvider class.
			The output consists of characters 0-9 and A-F.

		.PARAMETER length
			The length of the resulting hexadecimal number. Default is 20 characters

		.PARAMETER chars
			The character set to use for generation. Default is "0123456789ABCDEF"

		.EXAMPLE
			Get-RandomHexNumber -length 8

			Generates an 8-character hexadecimal string like "A3F8B2D1"

		.EXAMPLE
			Get-RandomHexNumber

			Generates a 20-character hexadecimal string using default length

		.INPUTS
			A number specifying the length

		.OUTPUTS
			A hexadecimal string

		.NOTES
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

