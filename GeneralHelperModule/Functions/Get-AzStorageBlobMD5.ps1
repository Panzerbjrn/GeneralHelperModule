Function Get-AzStorageBlobMD5 {
    <#
		.SYNOPSIS
			Gets the MD5 hash of an Azure Storage blob

		.DESCRIPTION
			This function retrieves the MD5 hash from an Azure Storage blob's properties and converts it from Base64 to a hexadecimal string.
			Accepts blob objects from the pipeline.

		.PARAMETER Blob
			The Azure Storage blob object from which to retrieve the MD5 hash

		.EXAMPLE
			Get-AzStorageBlob -Container "mycontainer" -Blob "myfile.txt" | Get-AzStorageBlobMD5

			Gets the MD5 hash of the specified blob

		.EXAMPLE
			$blob = Get-AzStorageBlob -Container "backups" -Blob "database.bak"
			Get-AzStorageBlobMD5 -Blob $blob

			Retrieves the MD5 hash for a specific blob

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline = $true, Position = 0)]
        [Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob]$Blob
    )
    BEGIN {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
    }
    PROCESS {
        #$Blob.ICloudBlob.Properties.ContentMD5
        $MD5Sum = [convert]::FromBase64String($Blob.ICloudBlob.Properties.ContentMD5)
        $hdhash = [BitConverter]::ToString($MD5Sum).Replace('-', '')
    }
    END {
        $hdhash
    }
}

