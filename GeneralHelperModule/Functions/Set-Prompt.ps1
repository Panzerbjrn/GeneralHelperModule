function Set-Prompt {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param()
    begin {}
    process {
        if ($pscmdlet.ShouldProcess("console")) {
            # Determine Admin; set Symbol variable.
            if ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups -match 'S-1-5-32-544')) {
                $Symbol = '#'
            }
            else {
                $Symbol = '$'
            }

            if ((Get-Location).Path -eq $env:USERPROFILE) {
                $Path = '~'
            }
            else {
                $Path = (Get-Location).Path
            }

            # Create prompt.
            "[$($env:USERNAME.ToLower())@$($env:COMPUTERNAME.ToLower()) $Path]$Symbol "
        }
    }
    end {}
} # End Function: prompt.


