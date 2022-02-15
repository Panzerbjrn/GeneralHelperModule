Function Get-LastReboot{
<#
	.SYNOPSIS
		Get-LastReboot is designed to return the last reboot time of a server or client.
	.DESCRIPTION
		Get-LastReboot filters the system event logs looking for the last reboot event (or shutdown) and returns all the information related to the incident.
	.PARAMETER Computer
		The name of the computer that you wish to determine it's last boot up time.
		If left blank, it defaults to the local machine.
	.EXAMPLE
		Get-LastReboot DC1
		
		This will return the last reboot time of DC1
	.EXAMPLE
		Get-ChildItem AD:"OU=Servers,OU=Computers,DC=Contoso,DC=Local" | Select Name | Get-LastReboot
		
		This grabs the last reboots for any machines in the Servers OU.
	.OUTPUTS
		Object: System.Management.Automation.PSCustomObject
		IF it was a clean boot:
			Contains:
				Cleanboot		[Bool]
				Code			[String]
				Comment			[String]
				ComputerName	[String]
				LastBoot		[DateTime]
				Message			[String]
				Process			[String]
				Reason			[String]
				Type			[String]
				UpTime			[TimeSpan]
				User			[String]
		Else
			Contains:
				Cleanboot		[Bool]
				ComputerName	[String]
				LastBoot		[DateTime]
				Message			[String]
				UpTime			[TimeSpan]
	.NOTES
		Author: Twon of An
	.LINK
		New-Timespan
		Get-EventLog
#>
	Param(
		[Parameter(Position=0,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$true)]
		[alias("Name","ComputerName")]
		[string[]]$Computer=@($env:ComputerName)
	)
	Begin{
		$Result = @()
	}
	Process{
		ForEach($machine in $Computer){
			If(-not (Test-Connection -ComputerName $machine -Count 1 -quiet)){ #Make sure we can connect to it...
				Write-Host "$([string]$machine.toupper()) cannot be reached..."
				Break
			}
			Else{
				If($machine -ne $env:computername){ #If it is a remote machine, make sure RemoteRegistry is running so we can access the logs
					$RegServ = Get-Service remoteregistry -ComputerName $machine
					If($RegServ.status -ne "Running"){
						Set-Service remoteregistry -ComputerName $machine -status Running
					}
				}
				$SuccessfullReboot = Get-EventLog system -ComputerName $machine -InstanceId 2147484722 -Newest 1
				$UnSuccessfullReboot = Get-EventLog system -ComputerName $machine -InstanceId 41 -Newest 1
				$Event = If($SuccessfullReboot.TimeWritten -gt $UnSuccessfullReboot.Timewritten){$SuccessfullReboot;$Cleanboot = $true}Else{$UnSuccessfullReboot}
				$LastRebootTime = $Event.TimeGenerated
				$UpTime = New-TimeSpan -start $LastRebootTime -end $(Get-Date)
				If($CleanBoot){
					$Result = $Result + (New-Object PSObject -Property @{ #Build the object for return
						"Code" = $Event.ReplacementStrings[3]
						"Comment" = $Event.ReplacementStrings[5]
						"ComputerName" = $machine.toupper()
						"LastBoot" = $LastRebootTime
						"Message" = $Event.Message
						"Process" = $Event.ReplacementStrings[0]
						"Reason" = $Event.ReplacementStrings[2]
						"Type" = $Event.ReplacementStrings[4]
						"UpTime" = $UpTime
						"User" = $Event.ReplacementStrings[6]
						"CleanBoot" = $true
					})
				}
				Else{
					$Result = $Result + (New-Object PSObject -Property @{ #Build the object for return
						"ComputerName" = $machine.toupper()
						"LastBoot" = $LastRebootTime
						"Message" = $Event.Message
						"UpTime" = $UpTime
						"CleanBoot" = $false
					})
				}
			}
		}
	}
	End{
		$Result
	}
}
