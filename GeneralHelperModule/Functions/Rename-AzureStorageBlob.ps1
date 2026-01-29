Function Rename-AzureStorageBlob {
    <#
		.SYNOPSIS
			Renames Azure Storage blobs

		.DESCRIPTION
			This function "renames" Azure blobs by copying them to a new name and then deleting the original file once the copy job has been completed.
			Azure Storage doesn't natively support renaming, so this copy-and-delete approach is necessary.

		.PARAMETER Blob
			The Azure Storage blob object to rename (accepts pipeline input)

		.PARAMETER NewName
			The new name for the blob (can include folder path prefix)

		.EXAMPLE
			$Blob = Get-AzStorageBlob -Container MyContainer -Context $Context -Blob TestFile.txt
			Rename-AzureStorageBlob -Blob $Blob -NewName "Filetest.txt"

			This example will get an Azure blob and rename it from "TestFile.txt" to "FileTest.txt"

		.EXAMPLE
			Get-AzStorageBlob -Container MyContainer -Context $Context -Prefix ArchiveFiles/ | foreach {Rename-AzureStorageBlob -Blob $_ -NewName "ArchivedOld/$($_.Name.Split('/')[-1])" -Verbose}

			This example will get some Azure blobs and rename them all by moving them to a different folder prefix

		.INPUTS
			Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob

		.OUTPUTS
			None

		.NOTES
			There's no native way to rename files in Azure Storage; they have to be copied and the original then deleted

		.LINK
			https://github.com/Panzerbjrn/

	#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory, ValueFromPipeline = $true, Position = 0)]
        [Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob]$Blob,

        [Parameter(Mandatory, Position = 1)]
        [string]$NewName
    )

    BEGIN {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }

    PROCESS {
        $StartAzStorageBlobCopySplat = @{
            ICloudBlob    = $Blob.ICloudBlob
            DestBlob      = $NewName
            Context       = $Blob.Context
            DestContainer = $Blob.ICloudBlob.Container.Name
        }
        if ($PSBoundParameters.ContainsKey('Force')) {
            $StartAzStorageBlobCopySplat.Force = $True
        }

        $BlobCopyAction = Start-AzStorageBlobCopy @StartAzStorageBlobCopySplat

        $status = $BlobCopyAction | Get-AzStorageBlobCopyState

        while ($status.Status -ne 'Success') {
            $status = $blobCopyAction | Get-AzStorageBlobCopyState
            Start-Sleep -Milliseconds 50
        }

        $Blob | Remove-AzStorageBlob -Force
    }
}


