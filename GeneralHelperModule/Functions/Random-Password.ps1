Function Random-Password ($Length = 15){
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
		$Punc = 46..46
		$Digits = 48..57
		$Letters = 65..90 + 97..122
		$password = Get-Random -count $Length `
				-input ($Punc + $Digits + $Letters) |
						% -begin { $aa = $Null } `
						-process {$aa += [char]$_} `
						-end {$aa}
		return $password
}