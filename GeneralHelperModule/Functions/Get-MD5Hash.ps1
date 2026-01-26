function Get-MD5Hash {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

	#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][String]$Path
    )

    if (Test-Path -Path $Path) {
        try {
            # Create the hasher and get the content
            $crypto = [System.Security.Cryptography.MD5]::Create()
            $content = Get-Content -Path $Path -Encoding byte
            $hash = [System.Convert]::ToBase64String($crypto.ComputeHash($content))
        }
        catch {
            $hash = $Null
        }
    }
    else {
        # File doesn't exist, can't calculate hash
        $hash = $Null
    }

    # Return the Base64 encoded MD5 hash
    return $hash
}

