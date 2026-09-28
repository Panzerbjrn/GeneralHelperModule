Function Set-Prompt {
    <#
		.SYNOPSIS
			Sets a custom PowerShell prompt

		.DESCRIPTION
			This function creates a Linux-style PowerShell prompt showing username@computername and current path.
			The prompt uses '#' for administrators and '$' for regular users, similar to bash shells.

		.EXAMPLE
			Set-Prompt

			Sets the PowerShell prompt to display [username@computername path]$ or [username@computername path]# for administrators

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param()
    BEGIN{}
    PROCESS{
        IF($pscmdlet.ShouldProcess("console")) {
            # Determine Admin; set Symbol variable.
            IF([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups -match 'S-1-5-32-544')) {
                $Symbol = '#'
            }ELSE {
                $Symbol = '$'
            }

            IF((Get-Location).Path -eq $env:USERPROFILE) {
                $Path = '~'
            }ELSE {
                $Path = (Get-Location).Path
            }

            # Create prompt.
            "[$($env:USERNAME.ToLower())@$($env:COMPUTERNAME.ToLower()) $Path]$Symbol "
        }
    }
    END{}
} # End Function: prompt.


