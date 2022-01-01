Function Get-AzStorageBlobMD5{
[CmdletBinding()]
	Param(
		[Parameter(Mandatory, ValueFromPipeline=$true, Position=0)]
		[Microsoft.WindowsAzure.Commands.Common.Storage.ResourceModel.AzureStorageBlob]$Blob
	)
	Begin {
		Write-Verbose "Beginning $($MyInvocation.Mycommand)"
	}
	Process {
        #$Blob.ICloudBlob.Properties.ContentMD5
        $md5sum = [convert]::FromBase64String($Blob.ICloudBlob.Properties.ContentMD5)
        $hdhash = [BitConverter]::ToString($md5sum).Replace('-','')
    }
    End{
        $hdhash
    }
}