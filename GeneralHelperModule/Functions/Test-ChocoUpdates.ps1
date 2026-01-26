function Test-ChocoUpdates {
    param([string[]]$Apps)
    foreach ($App in $Apps) {
        $Status = choco outdated --ignore-pinned --limit-output | Where-Object { $_ -like "$App|*" }
        if ($Status) {
            $Current, $Available, $Pinned = $Status.Split('|')[1, 2, 3]
            Write-Host "$App : Update available ($Current → $Available)" -ForegroundColor Yellow
        }
        else {
            Write-Host "$App : Up to date" -ForegroundColor Green
        }
    }
}

