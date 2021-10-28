Function Rename-AzureStorageBlob{
<#
	.SYNOPSIS
		This will "rename" azure blobs.

	.DESCRIPTION
		This will "rename" azure blobs by copying them, and then deleting the original file once the copy job has been completed.

	.INPUTS
		Command line

	.OUTPUTS
		None

	.NOTES
		There's no native way to rename files, they have to be copied and the original then deleted.

	.EXAMPLE
		This example will get an Azure blob and rename it from "TestFile.txt" to "FileTest.txt"

		$Blob = Get-AzStorageBlob -Container MyContainer -Context $Context -Blob TestFile.txt
		Rename-AzureStorageBlob -Blob $Blob -NewName "Filetest.txt"

	.EXAMPLE
		This example will get some Azure blobs, and renamed them all

		Get-AzStorageBlob -Container MyContainer -Context $Context -Prefix ArchiveFiles/ | foreach {Rename-AzureStorageBlob -Blob $_ -NewName "ArchivedOld/$($_.Name.Split('/')[-1])" -Verbose}

	.LINK
		https://github.com/Panzerbjrn/
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact='Medium')]
	Param(
		[Parameter(Mandatory, ValueFromPipeline=$true, Position=0)]
		[Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob]$Blob,

		[Parameter(Mandatory, Position=1)]
		[string]$NewName
	)

	Begin {
		Write-Verbose "Beginning $($MyInvocation.Mycommand)"
		if (-not $PSBoundParameters.ContainsKey('Confirm')){
			$ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
		}
		if (-not $PSBoundParameters.ContainsKey('WhatIf')){
			$WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
		}
	}

	Process {
	  $StartAzStorageBlobCopySplat = @{
		ICloudBlob = $Blob.ICloudBlob
		DestBlob = $NewName
		Context = $Blob.Context
		DestContainer = $Blob.ICloudBlob.Container.Name
	}
	if ($PSBoundParameters.ContainsKey('Force')){
		$StartAzStorageBlobCopySplat.Force = $True
	}

	$BlobCopyAction = Start-AzStorageBlobCopy @StartAzStorageBlobCopySplat 
		

	$status = $BlobCopyAction | Get-AzStorageBlobCopyState

	while ($status.Status -ne 'Success'){
		$status = $blobCopyAction | Get-AzStorageBlobCopyState
		Start-Sleep -Milliseconds 50
	}

	$Blob | Remove-AzStorageBlob -Force
  }
}
