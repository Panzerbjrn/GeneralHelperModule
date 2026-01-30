#region Script Header
#	Thought for the day: It is a rough road that leads to the heights of greatness. - Lucius Annaeus Seneca
#	NAME: LarsModulesGeneric.psm1
#	AUTHOR: Lars Panzerbjørn
#	CONTACT: GitHub: Panzerbjrn / Twitter: Panzerbjrn
#	DATE: 2018.11.01
#	VERSION: 0.7 - 2018.11.01 - Slowly getting started
#	VERSION: 1.0 - 2018.11.23 - Manifest and Module files created
#
#	SYNOPSIS:
#
#
#	#DESCRIPTION:
#
#
#	REQUIREMENTS:
#
#endregion Script Header

#Requires -Version 3.0

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

