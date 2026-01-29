Function Get-MD5Hash {
    <#
		.SYNOPSIS
			Calculates the MD5 hash of a file

		.DESCRIPTION
			This function computes the MD5 hash of a specified file and returns it as a Base64-encoded string.
			Returns null if the file doesn't exist or if an error occurs during hash calculation.

		.PARAMETER Path
			The full path to the file to hash

		.EXAMPLE
			Get-MD5Hash -Path "C:\Files\document.txt"

			Calculates and returns the Base64-encoded MD5 hash of document.txt

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

