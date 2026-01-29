Function Test-ChocoUpdate {
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


