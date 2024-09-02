Function New-EncryptedCredentialKeys{
<#
	.SYNOPSIS
		Creates a new a set of encrypted credential keys

	.DESCRIPTION
		Creates a new a set of encrypted credential keys. Once created, they can be passed to a credentials parameter, exactly like you would a username/password combination.

	.PARAMETER Path
		This is the path to where you want the Keys to be saved. Default is C:\Temp

	.INPUTS
		None

	.OUTPUTS
		A key file and encrypted password file.

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjrn
		Creation Date:		2019.01.30
		Purpose/Change: 	Initial script development
		Change 2019.01.31:	Added Examples

	.EXAMPLE
		New-EncryptedCredentialKeys -Account "CentralIndustrial\Serv_ServiceAccount" -Path "C:\_Keys\ServAcc" -Passsword "S3kr1tVV0rd"

	.EXAMPLE
		New-EncryptedCredentialKeys -Account "Panzerbjrn_L" -Passsword "DenmarkWillTakeBackItsColonies"

	.EXAMPLE
		New-EncryptedCredentialKeys -Account "Panzerbjrn_L@CentralIndustrial.eu" -$Passssword "DenmarkWillTakeBackItsColonies" -Service Azure
#>
	[CmdletBinding(PositionalBinding=$false)]
	[Alias('Create-EncryptedCredentialKeys')]
	Param
	(
		[Parameter(Mandatory)][string]$Account,
		[Parameter()][string]$Path="C:\Temp",
		[Parameter(Mandatory)][string]$Password,
		[Parameter()][string]$Service
	)

	BEGIN
	{
		$Path = $Path.TrimEnd('\')

		IF (!(Test-Path -Path $Path)){
			Try{New-Item -ItemType "Directory" -Path $Path -Force}
			Catch{"$($Path) doesn't exist, and couldn't be created"}
			Break
		}
		
		IF (!([string]::IsNullOrEmpty($Service))){
			$Path = ($Path + "\" + $Service + ".")
		}
		Else{
			$Path = ($Path + "\")
		}
	}
	PROCESS
	{
		#Creating Key File:
		$KeyFile = $Path + "AES.key"
		$Key = New-Object Byte[] 32
		[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
		$Key | out-file $KeyFile

		#Creating Password File:
		$PWDFile = $Path + "Password.txt"
		$ConvertedPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
		$ConvertedPassword | ConvertFrom-SecureString -key $Key | Out-File $PWDFile

		#Creating Username File:
		$USRNameFile = $Path + "Username.txt"
		$Account | Out-File $USRNameFile
		Write-Verbose "Keys created."
	}
	END
	{
		Write-Verbose "
		Files created:
		$($PWDFile)
		$($USRNameFile)
		$($Keyfile)
		"
	}
}