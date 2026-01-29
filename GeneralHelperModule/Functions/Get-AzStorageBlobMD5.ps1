function Get-AzStorageBlobMD5 {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline = $true, Position = 0)]
        [Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob]$Blob
    )
    begin {
        Write-Verbose "Beginning $($MyInvocation.Mycommand)"
    }
    process {
        #$Blob.ICloudBlob.Properties.ContentMD5
        $MD5Sum = [convert]::FromBase64String($Blob.ICloudBlob.Properties.ContentMD5)
        $hdhash = [BitConverter]::ToString($MD5Sum).Replace('-', '')
    }
    end {
        $hdhash
    }
}

