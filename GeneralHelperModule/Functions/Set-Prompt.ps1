Function Set-Prompt {
	# Determine Admin; set Symbol variable.
	IF ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups -match 'S-1-5-32-544')) {
		$Symbol = '#'
	} Else {
		$Symbol = '$'
	}

	IF ((Get-Location).Path -eq $env:USERPROFILE) {
		$Path = '~'
	} Else {
		$Path = (Get-Location).Path
	}

	# Create prompt.
	"[$($env:USERNAME.ToLower())@$($env:COMPUTERNAME.ToLower()) $Path]$Symbol "
} # End Function: prompt.
