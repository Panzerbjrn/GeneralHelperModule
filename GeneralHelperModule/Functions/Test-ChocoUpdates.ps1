Function Test-ChocoUpdate {
    <#
		.SYNOPSIS
			Checks for available updates for Chocolatey packages

		.DESCRIPTION
			This function checks if specified Chocolatey packages have updates available by querying Chocolatey's outdated command.
			Displays current and available versions for each package.

		.PARAMETER Apps
			An array of Chocolatey package names to check for updates

		.EXAMPLE
			Test-ChocoUpdate -Apps "git","nodejs"

			Checks if updates are available for git and nodejs packages

		.EXAMPLE
			Test-ChocoUpdates -Apps @("vscode","7zip","vlc")

			Using the alias to check multiple packages for updates

	#>
    [Alias('Test-ChocoUpdates')]
    param([string[]]$Apps)
    foreach ($App in $Apps) {
        $Status = choco outdated --ignore-pinned --limit-output | Where-Object { $_ -like "$App|*" }
        if ($Status) {
            $Current, $Available, $Pinned = $Status.Split('|')[1, 2, 3]
            Write-Output "$App : Update available ($Current → $Available)"
        }
        else {
            Write-Output "$App : Up to date"
        }
    }
}


