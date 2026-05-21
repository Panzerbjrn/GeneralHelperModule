#region Script Header
#	Thought for the day: It is a rough road that leads to the heights of greatness. - Lucius Annaeus Seneca
#	NAME: GeneralHelperModule.psm1
#	AUTHOR: Lars Panzerbjørn
#	GitHub: Panzerbjrn
#	DATE: 2018.11.01
#
#endregion Script Header

#Requires -Version 5.0

[cmdletbinding()]
param()

Write-Verbose $PSScriptRoot

#Get public and private function definition files.
$Functions = @( Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue )
$Helpers = @( Get-ChildItem -Path $PSScriptRoot\Helpers\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
ForEach ($Import in @($Functions + $Helpers)) {
    try {
        Write-Verbose "Processing $($Import.Fullname)"
        . $Import.Fullname
    }
    catch {
        Write-Error -Message "Failed to Import function $($Import.Fullname): $_"
    }
}

Export-ModuleMember -Function $Functions.Basename

Set-Alias -Name Trust-PSRepository -Value Set-PSRepositoryTrust
Export-ModuleMember -Function Set-PSRepositoryTrust -Alias Trust-PSRepository