Function Update-ModuleVersion{
	[CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='High')]
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$ModulePath,

		[Switch]$Ask,
		[Switch]$Patch
	)

	BEGIN{
		Write-Verbose "#################################################################"
		Write-Verbose "Beginning $($MyInvocation.MyCommand.Name) on $($ENV:ComputerName) @ $(Get-Date -Format "yyyy.MM.dd HH:mm:ss")"
		Write-Verbose "#################################################################"
	}

	PROCESS{
		IF ((Get-Item $ModulePath).PSIsContainer -ne $True){
			$ModulePath = (Get-Item $ModulePath).DirectoryName
		}
		$ModuleName = $ModulePath.Trimend('\').Split('\')[-1]
		IF(Test-Path "$ModulePath\$ModuleName.psd1"){$ManifestPath = "$ModulePath\$ModuleName.psd1"}
		ELSEIF(Test-Path "$ModulePath\$ModuleName\$ModuleName.psd1"){$ManifestPath = "$ModulePath\$ModuleName\$ModuleName.psd1"}
		ELSE{THROW "No manifest was found"}

		Write-Verbose ("Importing {0}" -f $ModuleName)
		Import-Module $ManifestPath -Force
		$CommandList = Get-Command -Module $ModuleName
		Write-Verbose ("Removing {0}" -f $ModuleName)
		Remove-Module $ModuleName -Force

		Write-Output 'Calculating fingerprint'
		$Fingerprint = ForEach ( $Command in $CommandList ){
			ForEach ( $Parameter in $Command.parameters.keys ){
				'{0}:{1}' -f $Command.name, $Command.parameters[$Parameter].Name
				$Command.parameters[$Parameter].aliases | 
					ForEach-Object { Write-Verbose ('{0}:{1}' -f $Command.name, $_)}
			}
		}
		
		$MinorFeature = 0
		$MajorFeature = 0
		$VersionType = $Null
		IF($Patch){$VersionType = 'Patch'}
		IF(Test-Path $(Join-Path $ModulePath fingerprint) ){
			$OldFingerprint = Get-Content $(Join-Path $ModulePath fingerprint)
			Write-Output 'Detecting new features'
			$Fingerprint | Where {$_ -notin $OldFingerprint } | 
				ForEach-Object {$MinorFeature++}
				#ForEach-Object {$VersionType = 'Minor'; "  $_"}
			IF ($MinorFeature -ge 1){$VersionType = 'Minor'}
			Write-Output 'Detecting breaking changes'
			$OldFingerprint | Where {$_ -notin $Fingerprint } | 
				ForEach-Object {$MajorFeature++}
			IF ($MajorFeature -ge 1){$VersionType = 'Major'}
				#ForEach-Object {$VersionType = 'Major'; "  $_"}

			IF(!($Ask)){Set-Content -Path $(Join-Path $ModulePath fingerprint) -Value $Fingerprint}
		}
		ELSE{
			Write-Verbose "No Fingerprint found, saving current fingerprint"
			IF(!($Ask)){Set-Content -Path $(Join-Path $ModulePath fingerprint) -Value $Fingerprint}
		}
		
		IF($Ask){
			Write-output "$ModulePath\$ModuleName.psd1 would have been updated by $VersionType"
		}
		ELSE{
			IF(!([string]::IsNullOrEmpty($VersionType))){
				IF($PSCmdlet.ShouldProcess(
					"$ModulePath\$ModuleName.psd1 will be updated by $VersionType"
				)){
					Step-ModuleVersion -Path $ManifestPath -By $VersionType
				}
			}
		}
	
	}
}