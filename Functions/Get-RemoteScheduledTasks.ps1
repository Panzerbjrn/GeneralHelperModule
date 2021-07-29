Function Get-RemoteScheduledTasks {
<#
	.Synopsis
		PowerShell script to list all Scheduled Tasks and the User ID
	.DESCRIPTION
		This script scan the content of the c:\Windows\System32\tasks and search the UserID XML value.
		The output of the script is a comma-separated log file containing the ServerName, Task name, UserID.
#>
	[CmdletBinding(PositionalBinding=$false)]
	param(
		[Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,HelpMessage='What computer name would you like to target?')]
		[Alias('Host')][string[]]$ComputerName,
		[string]$LogFilePath = "C:\Temp\TasksLog.csv"
	)
	[int]$i=0
	$Servers = Get-ADComputer -Filter {NAME -like $ComputerName} -Properties * -SearchBase "DC=BrewinDolphin,DC=net" -Server "BrewinDolphin.net" | Select-Object -ExpandProperty Name | Sort-Object Name
	IF (!(Test-Path $LogFilePath)) {TRY{New-Item $LogFilePath}Catch{$_|Get-ErrorInfo}}
	Add-Content -Path $LogFilePath -Value "ServerName,TaskName,RunAs,Author,Enabled,Command,Argument"

	Write-Verbose	-Message "Trying to query $($Servers.count) servers found in AD"
	ForEach ($ServerName in $Servers)
	{
		$i++
		$Percentage = $i/$Servers.Count
		Write-Verbose "$($Percentage)% done"
		$path = "\\" + $ServerName + "\C$\Windows\System32\Tasks"
		$Tasks = Get-ChildItem -Path $path -File

		IF ($Tasks)
		{
			Write-Verbose -Message "I found $($Tasks.count) tasks for $ServerName"
		}

		ForEach ($TaskName in $Tasks)
		{
			$AbsolutePath = $path + "\" + $TaskName.Name
			$Task = [xml] (Get-Content $AbsolutePath)
			[STRING]$RunAs = $Task.Task.Principals.Principal.UserId
			[STRING]$Author = $Task.Task.RegistrationInfo.Author
			[STRING]$Enabled = $Task.Task.Settings.Enabled
			[STRING]$Command = $Task.Task.Actions.Exec.Command
			#Write-Verbose -Message "$ServerName,$TaskName,$RunAs,$Author,$Enabled"
			IF ($Enabled -eq "true")
			{
				Write-Verbose -Message "Writing the log file with values for $ServerName"
				Add-content -path $LogFilePath -Value "$ServerName,$TaskName,$RunAs,$Author,$Enabled,$Command,$Argument"
			}
		}
	}
}
