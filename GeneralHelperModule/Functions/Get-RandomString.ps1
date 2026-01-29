Function Get-RandomString {
    <#
		.SYNOPSIS
			Generates a random string of specified length and type

		.DESCRIPTION
			This function generates a random string using different character sets: hexadecimal (0-9, A-H), decimal (0-9), or alphanumeric (0-9, A-Z, a-z).
			Uses Get-Random to create cryptographically random strings.

		.PARAMETER NumberOfCharacters
			The number of characters to generate in the random string. Default is 3

		.PARAMETER Hexidecimal
			Generate a hexadecimal string (0-9, A-H)

		.PARAMETER Decimal
			Generate a decimal string (0-9)

		.PARAMETER AlphaNumeric
			Generate an alphanumeric string (0-9, A-Z, a-z)

		.EXAMPLE
			Get-RandomString -NumberOfCharacters 8 -Hexidecimal

			Generates an 8-character hexadecimal string like "A4F3B201"

		.EXAMPLE
			Get-RandomString -NumberOfCharacters 10 -AlphaNumeric

			Generates a 10-character alphanumeric string like "Kx3mN8zQ2p"

		.EXAMPLE
			Get-RandomString -NumberOfCharacters 6 -Decimal

			Generates a 6-character decimal string like "749382"

	#>
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Hex", Position = 0)]
        [Parameter(ParameterSetName = "Dec", Position = 0)]
        [Parameter(ParameterSetName = "AlphaNum", Position = 0)]
        [int]$NumberOfCharacters = "3",

        [Parameter(ParameterSetName = "Hex", Position = 1)]
        [switch]$Hexidecimal,

        [Parameter(ParameterSetName = "Dec", Position = 1)]
        [switch]$Decimal,

        [Parameter(ParameterSetName = "AlphaNum", Position = 1)]
        [switch]$AlphaNumeric
    )
    $PSCmdlet.ParameterSetName
    if ($Hexidecimal) {
        -join ((48..57) + (65..72) | Get-Random -Count $NumberOfCharacters | ForEach-Object { [char]$_ })
    }
    if ($Decimal) {
        -join ((0..9) | Get-Random -Count $NumberOfCharacters | ForEach-Object { $_ })
    }
    if ($AlphaNumeric) {
        -join ((48..57) + (65..90) + (97..122) | Get-Random -Count $NumberOfCharacters | ForEach-Object { [char]$_ })
    }
}


