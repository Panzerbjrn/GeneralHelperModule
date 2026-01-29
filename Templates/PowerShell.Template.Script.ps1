#region Header
<#
.SYNOPSIS
	<Overview of script>

.DESCRIPTION
	<Brief description of script>

.PARAMETER <Parameter_Name>
	<Brief description of parameter input required. Repeat this attribute if required>

.INPUTS
	<Inputs if any, otherwise state None>

.OUTPUTS
	<Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>

.NOTES
	Version:		1.0
	Author:			<Name>
	Creation Date:	<Date>
	Purpose/Change:	Initial script development

.EXAMPLE
	<Example goes here. Repeat this attribute for more than one example>
#>

#endregion Header
#region Functions
#-----------------------------------------------------------[Functions]------------------------------------------------------------

try {
    Import-Module D:\PowerShell.Modules\HelperModule\HelperModule.psm1 -NoClobber
}
catch {
    exit
}

#endregion Functions
#region Declarations
#----------------------------------------------------------[Declarations]----------------------------------------------------------
Write-Verbose "Declarations" -Verbose
$LogFile = "C:\Temp\$($MyInvocation.MyCommand.Name).LogFile." + (Get-Date -Format yyyy.MM.dd_HH.mm.ss) + ".txt"
Write-LogFile -LogFilePath $LogFile -Message "Starting Script Declarations @ $(Get-Date -Format yyyy.MM.dd_HH.mm.ss)"


#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#endregion Declarations
#region Initialisations
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
##Here we make some initial initialisations and connections needed by the script.
Write-LogFile -LogFilePath $LogFile -Message "Starting Script Initialisations @ $(Get-Date -Format yyyy.MM.dd_HH.mm.ss)"

$HostServer = $ENV:ComputerName
$Date = Get-Date -UFormat "%Y.%m.%d @ %R"
$ScriptName = $MyInvocation.MyCommand.Name
#Script Version
$sScriptVersion = "1.0"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "<script_name>.log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#endregion Initialisations
#region Execution
#---------------------------------------------------------[Execution]--------------------------------------------------------
##Here we execute the script.
Write-Verbose "Starting Script Execution" -Verbose
Write-LogFile -LogFilePath $LogFile -Message "Starting Script Execution @ $(Get-Date -Format yyyy.MM.dd.HH.mm.ss)"

#Script Execution goes here
#Log-Finish -LogPath $sLogFile
