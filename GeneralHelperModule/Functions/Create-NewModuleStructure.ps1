Function Create-NewModuleStructure{
<#
	.SYNOPSIS
		Creates a new Module Tree + Files

	.DESCRIPTION
		Creates a new Module Tree + Files

	.PARAMETER Path
		This is the path to where you want the Module + Tree created

	.PARAMETER ModuleName
		This is the name of the module you are creating.

	.PARAMETER Description
		This is the description for the module you are creating.

	.EXAMPLE
		Create-NewModuleStructure -Path C:\Temp\ -ModuleName Test-Module -Author LarsP -Description "Test PowerShell Module"

	.INPUTS
		None

	.OUTPUTS
		None

	.NOTES
		Version:			1.0
		Author:			Lars Panzerbjrn
		Creation Date:	2018.11.08
		Purpose/Change: Initial script development
		2018.12.03 - Update:	Added Content of PSM1 file
		2019.02.07 - Update:	Added Content of About_help file. Tidied up some code.

	.EXAMPLE
		Create-NewModuleStructure -ModuleName ServiceNowCMDB -Path C:\Temp -Description "Helper Functions to work with ServiceNow's CMDB"
#>
	[CmdletBinding(PositionalBinding=$false)]
	Param(
		[Parameter()][string]$Author="Lars Panzerbjørn",
		[Parameter(Mandatory=$True)][string]$ModuleName,
		[Parameter()][string]$Path="C:\Temp",
		[Parameter()][string]$GitHub="Panzerbjrn",
		[Parameter()][string]$Email="",
		[Parameter()][string]$Twitter="lpetersson",
		[Parameter()][string]$Description = 'New PowerShell module'
	)

	BEGIN
	{
		$Date = Get-Date -f yyyy.MM.dd
		Write-Verbose "Path is $Path"
$PSMContent = "#region Script Header
#	Thought for the day:
#	NAME: $($ModuleName).psm1
#	AUTHOR: $($Author)
#	CONTACT: $($Email) / GitHub: $($GitHub) / Twitter: $($Twitter)
#	DATE: $($Date)
#	VERSION: 0.1 - $($Date) - Module Created with Create-NewModuleStructure by Lars Panzerbj�rn
#
#	SYNOPSIS:
#
#
#	DESCRIPTION:
#	$($Description)
#
#	REQUIREMENTS:
#
#endregion Script Header

#Requires -Version 4.0

[CmdletBinding(PositionalBinding=`$false)]
param()

Write-Verbose `$PSScriptRoot

#Get Functions and Helpers function definition files.
`$Functions	= @( Get-ChildItem -Path `$PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue )
`$Helpers = @( Get-ChildItem -Path `$PSScriptRoot\Helpers\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
ForEach (`$Import in @(`$Functions + `$Helpers)){
	Try{
		. `$Import.Fullname
	}
	Catch{
		Write-Error -Message `"Failed to Import function `$(`$Import.Fullname): `$_`"
	}
}

Export-ModuleMember -Function `$Functions.Basename
"
$AboutHelpContent = "TOPIC
		about_$($ModuleName)

SHORT DESCRIPTION
		Default: A short, one-line description of the topic contents.

LONG DESCRIPTION
		Default: A detailed, full description of the subject or purpose of the module.

EXAMPLES
		Default: Examples of how to use the module or how the subject feature works in practice.

KEYWORDS
		Default: Terms or titles on which you might expect your users to search for the information in this topic.

SEE ALSO
		Default: Text-only references for further reading. Hyperlinks cannot work in the Windows PowerShell console.
"
	}

	PROCESS
	{
		$Path= Join-Path $Path $ModuleName
		Write-Verbose "Creating the module and function directories"
		IF(!(Test-Path -Path ($Path))) {New-Item ($Path) -ItemType Directory -Force}
		IF(!(Test-Path -Path ($Path+"\Helpers"))) {New-Item ($Path+"\Helpers") -ItemType Directory -Force} # For private/Helper functions that should not be exposed to end users
		IF(!(Test-Path -Path ($Path+"\Functions"))) {New-Item ($Path+"\Functions") -ItemType Directory -Force} # For public/exported functions
		IF(!(Test-Path -Path ($Path+"\en-GB"))) {New-Item ($Path+"\en-GB") -ItemType Directory -Force} # For English about_Help files
		IF(!(Test-Path -Path ($Path+"\WIP"))){New-Item ($Path+"\WIP") -ItemType Directory -Force} # For Functions that are Works in Progress
		IF(!(Test-Path -Path ($Path+"\Tests"))) {New-Item ($Path+"\Tests") -ItemType Directory -Force} # For Pester tests

		#Create the module and related files
		Write-Verbose "Creating the module and function files"
		IF(!(Test-Path -Path "$Path\$ModuleName.psm1")){New-Item "$Path\$ModuleName.psm1" -ItemType File}
		IF(!(Test-Path -Path "$Path\en-GB\about_$ModuleName.help.txt")){New-Item "$Path\en-GB\about_$ModuleName.help.txt" -ItemType File}
		IF(!(Test-Path -Path "$Path\Tests\$ModuleName.Tests.ps1")){New-Item "$Path\Tests\$ModuleName.Tests.ps1" -ItemType File}

		Write-Verbose "Creating the module manifest"
		Write-Verbose "Path is $($Path+"\"+$ModuleName+".psd1")"
		Write-Verbose "RootModule is $($ModuleName.psm1)"
		Write-Verbose "Description is $($Description)"
		Write-Verbose "Author is $($Author)"
			$PSD1Path = ($Path+"\"+$ModuleName+".psd1")
			$RootModule = $ModuleName.psm1
			$Description = $Description
			$PowerShellVersion = "5.0"
			$Author = $Author
		Write-Verbose "Path is $Path"
		Write-Verbose "RootModule is $RootModule"
		Write-Verbose "Description is $Description"
		Write-Verbose "PowerShellVersion is $PowerShellVersion"
		Write-Verbose "Author is $Author"
		New-ModuleManifest -Path $PSD1Path -Author $Author -RootModule $RootModule -Description $Description -PowerShellVersion $PowerShellVersion
		$PSMContent | Add-Content "$Path\$ModuleName.psm1" -Force
		$AboutHelpContent | Add-Content "$Path\en-GB\about_$ModuleName.help.txt" -Force
	# Put the Public Functions/exported functions into the Functions folder and Helper functions into Helpers folder
	}
}