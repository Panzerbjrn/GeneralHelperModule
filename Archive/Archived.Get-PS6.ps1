function Get-PS6 {
    if ($PSV.Major -ne "6") {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $DirectURL = (Invoke-WebRequest 'https://github.com/PowerShell/PowerShell/releases/latest' -UseBasicParsing).links | Where-Object { $_.href -like "*win*x64*.msi" } | ForEach-Object HREF | Select-Object -First 1
        $Download = Invoke-WebRequest "https://github.com$DirectURL" -OutFile C:\Temp\PS6latest.msi
    }
    else { Write-Host "PowerShell 6 is Already Installed, it is super-dope..." }
}

