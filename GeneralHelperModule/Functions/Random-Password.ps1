Function New-RandomPassword {
    <#
		.SYNOPSIS
			Generates a random password

		.DESCRIPTION
			This function creates a cryptographically random password containing letters (uppercase and lowercase), digits, and periods.
			Uses Get-Random with a character set to generate secure passwords.

		.PARAMETER Length
			The length of the password to generate. Default is 15 characters

		.EXAMPLE
			New-RandomPassword

			Generates a 15-character random password

		.EXAMPLE
			New-RandomPassword -Length 20

			Generates a 20-character random password

		.EXAMPLE
			Random-Password -Length 12

			Using the alias to generate a 12-character password

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Random-Password')]
    param($Length = 15)
    BEGIN {}
    PROCESS {
        if ($pscmdlet.ShouldProcess("$Length characters long")) {
            $Punc = 46..46
            $Digits = 48..57
            $Letters = 65..90 + 97..122
            $password = Get-Random -Count $Length `
                -input ($Punc + $Digits + $Letters) |
                ForEach-Object -BEGIN { $aa = $Null } `
                    -PROCESS { $aa += [char]$_ } `
                    -END { $aa }
            return $password
        }
    }
    END {}
}

