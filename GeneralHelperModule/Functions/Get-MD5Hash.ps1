Function Get-MD5Hash {
    Param (
        [Parameter(Mandatory=$true)][String]$Path
    )
 
    If (Test-Path -Path $Path) {
        try {
            # Create the hasher and get the content
            $crypto = [System.Security.Cryptography.MD5]::Create()
            $content = Get-Content -Path $Path -Encoding byte
            $hash = [System.Convert]::ToBase64String($crypto.ComputeHash($content))
        } catch {
            $hash = $null
        }
    } Else {
        # File doesn't exist, can't calculate hash
        $hash = $null  
    }
     
    # Return the Base64 encoded MD5 hash
    return $hash
}