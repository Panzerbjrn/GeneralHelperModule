Function New-EncryptedCredentialKey {
    <#
		.SYNOPSIS
			Creates a new set of encrypted credential keys

		.DESCRIPTION
			Creates a new set of encrypted credential keys. Once created, they can be passed to a credentials parameter, exactly like you would a username/password combination.
			Uses AES encryption with a 256-bit key to secure the password.

		.PARAMETER Account
			The account name or username to create credentials for

		.PARAMETER Path
			The path to where you want the Keys to be saved. Default is C:\Temp

		.PARAMETER Password
			The password to encrypt and save

		.PARAMETER Service
			Optional service name to prefix the credential files with

		.INPUTS
			None

		.OUTPUTS
			Creates three files: AES.key, Password.txt, and Username.txt

		.NOTES
			Version:		1.0
			Author:			Lars Panzerbjrn
			Creation Date:	2019.01.30

		.EXAMPLE
			New-EncryptedCredentialKeys -Account "CentralIndustrial\Serv_ServiceAccount" -Path "C:\_Keys\ServAcc" -Password "S3kr1tVV0rd"

			Creates encrypted credential files for a service account

		.EXAMPLE
			New-EncryptedCredentialKeys -Account "Panzerbjrn_L" -Password "DenmarkWillTakeBackItsColonies"

			Creates encrypted credential files in the default C:\Temp location

		.EXAMPLE
			New-EncryptedCredentialKeys -Account "Panzerbjrn_L@CentralIndustrial.eu" -Password "DenmarkWillTakeBackItsColonies" -Service Azure

			Creates encrypted credential files with "Azure." prefix for Azure services

	#>
    [CmdletBinding(PositionalBinding = $False, SupportsShouldProcess = $true)]
    [Alias('Create-EncryptedCredentialKeys', 'New-EncryptedCredentialKeys')]
    param
    (
        [Parameter(Mandatory)][string]$Account,
        [Parameter()][string]$Path = "C:\Temp",
        [Parameter(Mandatory)][string]$Password,
        [Parameter()][string]$Service
    )

    BEGIN {
        $Path = $Path.TrimEnd('\')

        if (!(Test-Path -Path $Path)) {
            try { New-Item -ItemType "Directory" -Path $Path -Force }
            catch { "$($Path) doesn't exist, and couldn't be created" }
            break
        }

        if (!([string]::IsNullOrEmpty($Service))) {
            $Path = ($Path + "\" + $Service + ".")
        }
        else {
            $Path = ($Path + "\")
        }
    }
    PROCESS {
        if ($pscmdlet.ShouldProcess("system")) {
            #Creating Key File:
            $KeyFile = $Path + "AES.key"
            $Key = New-Object Byte[] 32
            [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
            $Key | Out-File $KeyFile

            #Creating Password File:
            $PWDFile = $Path + "Password.txt"
            $ConvertedPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
            $ConvertedPassword | ConvertFrom-SecureString -Key $Key | Out-File $PWDFile

            #Creating Username File:
            $USRNameFile = $Path + "Username.txt"
            $Account | Out-File $USRNameFile
            Write-Verbose "Keys created."
        }
    }
    END {
        Write-Verbose "
		Files created:
		$($PWDFile)
		$($USRNameFile)
		$($Keyfile)
		"
    }
}

