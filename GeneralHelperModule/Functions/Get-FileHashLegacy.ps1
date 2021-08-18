Function Get-FileHashLegacy
{
<#
	.SYNOPSIS
		Backport of Get-FileHash, which works on versions of PowerShell pre-4.0

	.DESCRIPTION
		This function mimics the functionality of Get-FileHash on systems with a version of PowerShell older than 4.0.
		Currently this is only funcional for whole directories.

	.OUTPUTS
		List of algorithmic hashes

	.NOTES
		Version:				1.0
		Author:					Lars Panzerbjrn
		Creation Date:			2019.03.15
		Purpose/Change: 		Repurposed existing function that had no author associated. Improved aesthetics/formatting. Added parameter to choose whether to recurse.

	.EXAMPLE
		Get-FileHashLegacy -Path "C:\Windows\system32\"
		Gets the file hash of all files in C:\Windows\system32

	.EXAMPLE
		Get-FileHashLegacy -Path "C:\Windows\system32\" -Algorithm MD5
		Gets the MD5 file hash of anything below C:\Windows\system32
#>
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory=$true)]
		[string] $Path,
		[ValidateSet('SHA1','SHA256','SHA384','SHA512','MD5',ignorecase=$true)]
		[string] $Algorithm,
		[Parameter(Mandatory=$False)][switch]$Recurse
		)

	# Go through specified path
	IF($Recurse){$FilesList = Get-ChildItem $Path -Recurse -ErrorAction "SilentlyContinue" | Where-Object {-not $_.PSIsContainer}}
	IF(!($Recurse)){$FilesList = Get-ChildItem $Path -ErrorAction "SilentlyContinue" | Where-Object {-not $_.PSIsContainer}}

	ForEach ($File in $FilesList) {
		Try {
			# Set CryptoServiceProvider depending on chosen algorithm
			$CryptoServiceProvider = New-Object -TypeName System.Security.Cryptography.$($Algorithm)CryptoServiceProvider
			$Hash = [System.BitConverter]::ToString($CryptoServiceProvider.ComputeHash([System.IO.File]::Open($($File.FullName),[System.IO.Filemode]::Open,[System.IO.FileAccess]::Read))) -replace "-",""

			# Format similarly to Get-FileHash default view
			[PSCustomObject]@{
			"Algorithm" = $Algorithm
			"Hash" = $Hash
			"Path" = $File.FullName
			} #PSCustomObject

		} #Try
		catch {Write-Warning "Error reading $($File.FullName)!"}
	} #ForEach
} #Function