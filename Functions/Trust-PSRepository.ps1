Function Trust-PSRepository
{
	$Repo = Get-PSRepository
	Set-PSRepository -InstallationPolicy Trusted -Name $Repo.Name -SourceLocation $Repo.SourceLocation
}