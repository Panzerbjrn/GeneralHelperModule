Function Set-PSRepositoryTrust {
    <#
		.SYNOPSIS
			Sets all registered PowerShell repositories to Trusted

		.DESCRIPTION
			This function retrieves all registered PowerShell repositories and sets their installation policy to Trusted.
			This eliminates prompts when installing modules from these repositories.

		.EXAMPLE
			Set-PSRepositoryTrust

			Sets all registered repositories to Trusted installation policy

		.EXAMPLE
			Trust-PSRepository

			Using the alias to trust all repositories

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Trust-PSRepository')]
    param()
    BEGIN {}
    PROCESS {
        if ($pscmdlet.ShouldProcess("repositories registered in the system")) {
            $Repo = Get-PSRepository
            Set-PSRepository -InstallationPolicy Trusted -Name $Repo.Name -SourceLocation $Repo.SourceLocation
        }
    }
    END {}
}

