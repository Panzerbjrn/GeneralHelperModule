Function Set-ConsoleConfig {
    <#
		.SYNOPSIS
			Changes the PowerShell console title

		.DESCRIPTION
			This function changes the PowerShell console window title. It can either set a custom title or automatically set it based on administrator status.

		.PARAMETER Title
			The custom title you would like to set for the console window

		.PARAMETER AdminCheck
			When specified, automatically sets the title based on whether the console is running as administrator

		.EXAMPLE
			Set-ConsoleConfig -Title "Production Server"

			Sets the console title to "Production Server"

		.EXAMPLE
			Set-ConsoleConfig -AdminCheck

			Sets the console title to indicate admin or regular user status

		.INPUTS
			Input is from command line

		.NOTES
			Author:			Lars Panzerbjørn
			Creation Date:	2020.01.13

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ParameterSetName = "Title")]
        [string[]]$Title,

        [Parameter(ParameterSetName = "AdminCheck")]
        [Parameter()]
        [switch]$AdminCheck
    )
    BEGIN{}
    PROCESS{
        IF($pscmdlet.ShouldProcess("PowerShell Console")) {
            IF($PSCmdlet.ParameterSetName -eq "Title") {
                $Host.UI.RawUI.WindowTitle = "$Title"
            }

            IF($PSCmdlet.ParameterSetName -eq "AdminCheck") {
                IF(-not (Test-IsAdministrator)) {
                    $Host.UI.RawUI.WindowTitle = "Regular PowerShell Operations Console"
                }
                IF(Test-IsAdministrator) {
                    $Host.UI.RawUI.WindowTitle = "***ROOT PowerShell Operations Console ROOT***"
                }
            }
        }
    }
    END{}
}

