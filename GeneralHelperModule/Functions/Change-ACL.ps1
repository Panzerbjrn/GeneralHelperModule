Function Set-FolderACL {
    <#
	.SYNOPSIS
		This function will add or remove an ACE to the ACL for a directory.

	.DESCRIPTION
		This function will add or remov e an ACE to the ACL for a directory.

	.PARAMETER Directory
		This is the directory you will add/remove an ACE for.

	.PARAMETER UserNames
		These are the UserNames of the user(s) you want to change permissions for.

	.PARAMETER AccessLevel
		This is the level of accesss you want to grant for the user(s). If you are removing perissions, all inherited levels are removed

	.PARAMETER Add
		This switch specifies whether to add the permissions specified in the AccessLevel Parameter

	.PARAMETER Remove
		This switch specifies whether to remove the user's permissions

	.INPUTS
		None

	.OUTPUTS
		None

	.NOTES
		Author:				Lars Panzerbjrn

	.EXAMPLE
		Change-ACL -Directory "\\lonfs1\InfServices\Sec\SecOps" -UserNames Panzerbjrn_L_a -AccessLevel Write -Add

		This will give the user Panzerbjrn_L_a access to write to the directory.

	.EXAMPLE
		Change-ACL -Directory "\\lonfs1\InfServices\Sec\SecOps" -UserNames Panzerbjrn_L_a -Remove

		This will remove the user Panzerbjrn_L_a from the ACL for the directory.
#>
    [CmdletBinding(PositionalBinding = $False, SupportsShouldProcess = $true)]
    [Alias('Change-ACL')]
    param(
        [Parameter(Mandatory = $True, ParameterSetName = "Add")]
        [Parameter(Mandatory = $True, ParameterSetName = "Remove")]
        [string[]]$UserNames,

        [Parameter(Mandatory = $True, ParameterSetName = "Add")]
        [Parameter(Mandatory = $True, ParameterSetName = "Remove")]
        [string]$Directory,

        [Parameter(Mandatory = $True, ParameterSetName = "Add")]
        [ValidateSet("ListDirectory", "ReadData", "WriteData", "CreateFiles", "CreateDirectories", "AppendData", "ReadExtendedAttributes", "WriteExtendedAttributes", "Traverse", "ExecuteFile", "DeleteSubdirectoriesAndFiles", "ReadAttributes,WriteAttributes", "Write", "Delete", "ReadPermissions", "Read", "ReadAndExecute", "Modify", "ChangePermissions", "TakeOwnership", "Synchronize", "FullControl")]
        [String[]]$AccessLevel,

        [Parameter(ParameterSetName = "Add")]
        [switch]$Add,

        [Parameter(ParameterSetName = "Remove")]
        [switch]$Remove
    )
    BEGIN {}
    PROCESS {
        if ($pscmdlet.ShouldProcess("directory:$Directory by $(if($add){"adding"}else{"removing"}) $($AccessLevel -join ',') permission(s) for $($Usernames -join ',') user(s)")) {
            $Path = $Directory
            $TestedPath = Test-Path $Path
            if ($TestedPath -eq $False) { Write-Verbose "$($Path) Doesn't exist; thank you please come again"; break }
            $ACL = (Get-Item $Path).GetAccessControl('Access')

            foreach ($UserName in $UserNames) {
                $USR = Get-ADUser -Filter { SamAccountName -like $UserName } -Properties *
                $Usrname = "CentralIndustrial\" + $USR.SamaccountName
                $Inherit = [system.security.accesscontrol.InheritanceFlags]"ContainerInherit, ObjectInherit"
                $Propagation = [system.security.accesscontrol.PropagationFlags]"None"
                $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Usrname, $AccessLevel, $Inherit, $Propagation, "Allow")
                if ($Add) { $ACL.AddAccessRule($AccessRule) }
                if ($Remove) { $ACL.RemoveAccessRuleAll($AccessRule) }
            }
            if (($Add) -or ($Remove)) { Set-Acl -path $Path -AclObject $Acl }
            else { Write-Verbose "No Add or Remove action was specified" }
        }
    }
    END {}
}

