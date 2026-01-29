Function New-RandomPassword {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

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

