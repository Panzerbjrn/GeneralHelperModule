function Update-ModuleVersion {
	<#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>

    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ModulePath,

        [Switch]$Ask,
        [Switch]$Patch
    )

    BEGIN {
        Write-Verbose "#################################################################"
        Write-Verbose "Beginning $($MyInvocation.MyCommand.Name) on $($ENV:ComputerName) @ $(Get-Date -Format 'yyyy.MM.dd HH:mm:ss')"
        Write-Verbose "#################################################################"
    }

    PROCESS {
        try {
            # Ensure ModulePath is a directory
            if ((Get-Item $ModulePath).PSIsContainer -ne $True) {
                $ModulePath = (Get-Item $ModulePath).DirectoryName
            }
            $ModuleName = $ModulePath.TrimEnd('\').Split('\')[-1]
            $ManifestPath = Get-ChildItem -Path $ModulePath -Filter "$ModuleName.psd1" -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName

            # Check if this function is part of the module being updated
            $CurrentModule = (Get-Command -Name $MyInvocation.MyCommand.Name).Module.Name
            if ($CurrentModule -eq $ModuleName) {
                Write-Verbose "This function is part of the module $ModuleName. Skipping module unloading."
            } else {
                Write-Verbose ("Importing {0}" -f $ModuleName)
                Import-Module -Name $ManifestPath -Force
                $CommandList = Get-Command -Module $ModuleName
                Write-Verbose ("Removing {0}" -f $ModuleName)
                Remove-Module -Name $ModuleName -Force
            }

            Write-Output 'Calculating fingerprint'
            $Fingerprint = @()

            # Calculate fingerprint for commands and parameters
            foreach ($Command in $CommandList) {
                foreach ($Parameter in $Command.Parameters.Keys) {
                    $Fingerprint += '{0}:{1}' -f $Command.Name, $Command.Parameters[$Parameter].Name
                    $Command.Parameters[$Parameter].Aliases | ForEach-Object {
                        $Fingerprint += '{0}:{1}' -f $Command.Name, $_
                    }
                }
            }

            # Calculate fingerprint for .txt files
            $TextFiles = Get-ChildItem -Path $ModulePath -Filter '*.txt' -Recurse
            foreach ($File in $TextFiles) {
                $FileContent = Get-Content -Path $File.FullName -Raw
                $FileHash = [System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA256Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($FileContent))).Replace("-", "")
                $Fingerprint += '{0}:{1}' -f $File.FullName, $FileHash
            }

            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            [version]$Version = $Manifest.ModuleVersion

            $MinorFeature = 0
            $MajorFeature = 0
            $VersionType = $null

            if ($Patch) {
                $VersionType = 'Patch'
                [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
            } elseif ([string]::IsNullOrEmpty($Fingerprint)) {
                $VersionType = 'Patch'
                [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
            } else {
                $OldFingerprint = if (Test-Path -Path (Join-Path $ModulePath 'fingerprint')) {
                    Get-Content -Path (Join-Path $ModulePath 'fingerprint')
                } else {
                    Write-Verbose "No Fingerprint found, saving current fingerprint"
                    $Fingerprint
                }

                if (Compare-Object -ReferenceObject $OldFingerprint -DifferenceObject $Fingerprint) {
                    Write-Output 'Detecting new features'
                    $Fingerprint | Where-Object { $_ -notin $OldFingerprint } | ForEach-Object { $MinorFeature++ }
                    if ($MinorFeature -ge 1) {
                        $VersionType = 'Minor'
                        [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, ($Version.Minor + 1), 0
                    }

                    Write-Output 'Detecting breaking changes'
                    $OldFingerprint | Where-Object { $_ -notin $Fingerprint } | ForEach-Object { $MajorFeature++ }
                    if ($MajorFeature -ge 1) {
                        $VersionType = 'Major'
                        [version]$NewVersion = "{0}.{1}.{2}" -f ($Version.Major + 1), 0, 0
                    }
                }

                if ($PSCmdlet.ShouldProcess("Fingerprint will be saved")) {
                    Set-Content -Path (Join-Path $ModulePath 'fingerprint') -Value $Fingerprint
                }
            }

            if ($Ask) {
                Write-Output "$(Join-Path $ModulePath "$ModuleName.psd1") would have been updated by $VersionType"
            } elseif ($VersionType) {
                if ($PSCmdlet.ShouldProcess("$ModulePath\$ModuleName.psd1 will be updated by $VersionType")) {
                    Update-ModuleManifest -Path $ManifestPath -ModuleVersion $NewVersion
                }
            }
        } catch {
            Write-Error "An error occurred: $_"
        }
    }
}
