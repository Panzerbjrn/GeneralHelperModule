Function Set-ConsoleConfig {
    <#
	.SYNOPSIS
		Changes the Console Title

	.DESCRIPTION
		Changes the Console Title

	.EXAMPLE
		Give an example of how to use it

	.PARAMETER Title
		What you would like the title to be.

	.INPUTS
		Input is from command line.

	.NOTES
		Author:				Lars Panzerbjørn
		Creation Date:		2020.01.13
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ParameterSetName = "Title")]
        [string[]]$Title,

        [Parameter(ParameterSetName = "AdminCheck")]
        [Parameter()]
        [switch]$AdminCheck
    )
    BEGIN {}
    PROCESS {
        if ($pscmdlet.ShouldProcess("PowerShell Console")) {
            if ($PSCmdlet.ParameterSetName -eq "Title") {
                $Host.UI.RawUI.WindowTitle = "$Title"
            }

            if ($PSCmdlet.ParameterSetName -eq "AdminCheck") {
                if (-not (Test-IsAdministrator)) {
                    $Host.UI.RawUI.WindowTitle = "Regular PowerShell Operations Console"
                }
                if (Test-IsAdministrator) {
                    $Host.UI.RawUI.WindowTitle = "***ROOT PowerShell Operations Console ROOT***"
                }
            }
        }
    }
    END {}
}

