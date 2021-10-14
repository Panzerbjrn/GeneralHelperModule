Function Get-PS6
{
	IF ($PSV.Major -ne "6")
		{
			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
			$DirectURL = (Invoke-Webrequest 'https://github.com/PowerShell/PowerShell/releases/latest' -UseBasicParsing).links | Where-Object {$_.href -Like "*win*x64*.msi"} | ForEach-Object HREF | Select-Object -first 1
			$Download = Invoke-Webrequest "https://github.com$DirectURL" -OutFile C:\Temp\PS6latest.msi
		}
	ELSE {Write-Host "PowerShell 6 is Already Installed, it is super-dope..."}
}
