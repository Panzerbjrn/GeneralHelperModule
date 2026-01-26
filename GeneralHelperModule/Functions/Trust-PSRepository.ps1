function Trust-PSRepository {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>

    $Repo = Get-PSRepository
    Set-PSRepository -InstallationPolicy Trusted -Name $Repo.Name -SourceLocation $Repo.SourceLocation
}
