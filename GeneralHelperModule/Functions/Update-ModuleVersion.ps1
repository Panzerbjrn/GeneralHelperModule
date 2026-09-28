Function Update-ModuleVersion {
    <#
		.SYNOPSIS
			Updates the version number of a PowerShell module based on detected changes

		.DESCRIPTION
			This function analyzes a PowerShell module's fingerprint (commands and parameters) to determine if the version should be incremented.
			It detects breaking changes (major version), new features (minor version), or bug fixes (patch version) and updates the module manifest accordingly.

		.PARAMETER ModulePath
			The path to the module directory or manifest file that should be updated

		.PARAMETER Ask
			When specified, displays what version update would occur without making any changes

		.PARAMETER Patch
			Forces a patch version increment (0.0.X) regardless of detected changes

		.EXAMPLE
			Update-ModuleVersion -ModulePath "C:\Modules\MyModule"

			Analyzes the module and updates the version based on detected changes

		.EXAMPLE
			Update-ModuleVersion -ModulePath "C:\Modules\MyModule" -Ask

			Shows what version update would occur without making changes

		.EXAMPLE
			Update-ModuleVersion -ModulePath "C:\Modules\MyModule" -Patch -Confirm:$false

			Forces a patch version update without confirmation

	#>

    [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ModulePath,

        [Switch]$Ask,
        [Switch]$Patch
    )

    BEGIN{
        Write-Verbose "#################################################################"
        Write-Verbose "Beginning $($MyInvocation.MyCommand.Name) on $($ENV:ComputerName) @ $(Get-Date -Format 'yyyy.MM.dd HH:mm:ss')"
        Write-Verbose "#################################################################"
    }

    PROCESS{
        TRY{
            # Ensure ModulePath is a directory
            IF((Get-Item $ModulePath).PSIsContainer -ne $True) {
                $ModulePath = (Get-Item $ModulePath).DirectoryName
            }
            $ModuleName = $ModulePath.TrimEnd('\').Split('\')[-1]
            $ManifestPath = Get-ChildItem -Path $ModulePath -Filter "$ModuleName.psd1" -Recurse -ErrorAction Stop | Select-Object -ExpandProperty FullName

            # Check if this function is part of the module being updated
            $CurrentModule = (Get-Command -Name $MyInvocation.MyCommand.Name).Module.Name
            IF($CurrentModule -eq $ModuleName) {
                Write-Verbose "This function is part of the module $ModuleName. Skipping module unloading."
            }ELSE {
                Write-Verbose ("Importing {0}" -f $ModuleName)
                Import-Module -Name $ManifestPath -Force
                $CommandList = Get-Command -Module $ModuleName
                Write-Verbose ("Removing {0}" -f $ModuleName)
                Remove-Module -Name $ModuleName -Force
            }

            Write-Output 'Calculating fingerprint'
            $Fingerprint = @()

            # Calculate fingerprint for commands and parameters
            ForEach ($Command in $CommandList) {
                ForEach ($Parameter in $Command.Parameters.Keys) {
                    $Fingerprint += '{0}:{1}' -f $Command.Name, $Command.Parameters[$Parameter].Name
                    $Command.Parameters[$Parameter].Aliases | ForEach-Object {
                        $Fingerprint += '{0}:{1}' -f $Command.Name, $_
                    }
                }
            }

            ## There's a to do here to figure out a way to check for changes to txt files
            <#             # #Calculate fingerprint for .txt files
            $TextFiles = Get-ChildItem -Path $ModulePath -Filter '*.txt' -Recurse -File -ErrorAction Continue
            ForEach ($File in $TextFiles) {
                $FileContent = Get-Content -Path $File.FullName -Raw
                $FileHash = [System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA256Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($FileContent))).Replace("-", "")
                $txtFingerprint += '{0}:{1}' -f $File.Name, $FileHash
            } #>

            $Manifest = Import-PowerShellDataFile -Path $ManifestPath
            [version]$Version = $Manifest.ModuleVersion

            $MinorFeature = 0
            $MajorFeature = 0
            $VersionType = $Null

            IF($Patch) {
                $VersionType = 'Patch'
                [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
            }ELSEIF([string]::IsNullOrEmpty($Fingerprint)) {
                $VersionType = 'Patch'
                [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
            }ELSE {
                # .NET alternative: $FingerprintPath = [System.IO.Path]::Combine($ModulePath, 'fingerprint')
                # .NET alternative: $OldFingerprint = IF([System.IO.File]::Exists($FingerprintPath)) { [System.IO.File]::ReadAllLines($FingerprintPath) }
                $OldFingerprint = IF(Test-Path -Path (Join-Path $ModulePath 'fingerprint')) { Get-Content -Path (Join-Path $ModulePath 'fingerprint') }ELSE {
                    Write-Verbose "No Fingerprint found, saving current fingerprint"
                    $Fingerprint
                }

                IF(Compare-Object -ReferenceObject $OldFingerprint -DifferenceObject $Fingerprint) {
                    Write-Output 'Detecting new features'
                    $Fingerprint | Where-Object { $_ -notin $OldFingerprint } | ForEach-Object { $MinorFeature++ }
                    IF($MinorFeature -ge 1) {
                        $VersionType = 'Minor'
                        [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, ($Version.Minor + 1), 0
                    }

                    Write-Output 'Detecting breaking changes'
                    $OldFingerprint | Where-Object { $_ -notin $Fingerprint } | ForEach-Object { $MajorFeature++ }
                    IF($MajorFeature -ge 1) {
                        $VersionType = 'Major'
                        [version]$NewVersion = "{0}.{1}.{2}" -f ($Version.Major + 1), 0, 0
                    }
                }

                IF($PSCmdlet.ShouldProcess("Fingerprint will be saved")) {
                    # .NET alternative: [System.IO.File]::WriteAllLines($FingerprintPath, $Fingerprint)
                    Set-Content -Path (Join-Path $ModulePath 'fingerprint') -Value $Fingerprint
                }
            }

            IF($Ask) {
                Write-Output "$(Join-Path $ModulePath "$ModuleName.psd1") would have been updated by $VersionType"
            }ELSEIF($VersionType) {
                IF($PSCmdlet.ShouldProcess("$ModulePath\$ModuleName.psd1 will be updated by $VersionType")) {
                    Update-ModuleManifest -Path $ManifestPath -ModuleVersion $NewVersion
                }
            }
        }CATCH{
            Write-Error "An error occurred: $_"
        }
    }
    END{
        IF($Version -ne $NewVersion) {
            Write-Output "Module $ModuleName Updated from $Version to $NewVersion"
        }
    }
}


