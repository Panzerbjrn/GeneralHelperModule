function Set-PSRepositoryTrust {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('Trust-PSRepository')]
    param()
    begin {}
    process {
        if ($pscmdlet.ShouldProcess("repositories registered in the system")) {
            $Repo = Get-PSRepository
            Set-PSRepository -InstallationPolicy Trusted -Name $Repo.Name -SourceLocation $Repo.SourceLocation
        }
    }
    end {}
}

