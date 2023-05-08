Function Get-LastReboot{
<#
	.SYNOPSIS
		Get-LastReboot is designed to return the last reboot time of a windows computer.
	.DESCRIPTION
		Get-LastReboot filters the system event logs looking for the last reboot event (or shutdown) and returns all the information related to the reboot.
	.PARAMETER Computer
		The name of the computer  you wish to interrogate. Default is your local machine.
	.EXAMPLE
		Get-LastReboot DC1
		
		This will return the last reboot time of DC1
	.EXAMPLE
		Get-ChildItem AD:"OU=Servers,OU=Computers,DC=CentralIndustrial,DC=EU" | Select Name | Get-LastReboot
		
		This outputs the last reboot for all machines in the Servers OU.
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
#>
	Param(
		[Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
		[alias("Name","ComputerName")]
		[string[]]$Computer = @($env:ComputerName)
	)
	Begin{
		$Result = @()
	}
	Process{
		ForEach($Machine in $Computer){
			IF(-not (Test-Connection -ComputerName $Machine -Count 1 -quiet)){ #Make sure we can connect to it...
				Write-OutPut "$([string]$Machine.toupper()) cannot be reached..."
				Break
			}
			ELSE{
				IF($Machine -ne $env:ComputerName){ #If it is a remote machine, make sure RemoteRegistry is running so we can access the logs
					$RegServ = Get-Service remoteregistry -ComputerName $Machine
					IF($RegServ.status -ne "Running"){
						Set-Service remoteregistry -ComputerName $Machine -status Running
					}
				}
				IF ($PSVersionTable.PSVersion.Major -eq 5){
					$SuccessfullReboot = Get-EventLog system -ComputerName $Machine -InstanceId 2147484722 -Newest 1
					$UnSuccessfullReboot = Get-EventLog system -ComputerName $Machine -InstanceId 41 -Newest 1
				}
				IF ($PSVersionTable.PSVersion.Major -eq 7){
					$SuccessfullReboot = Get-WinEvent -FilterHashtable @{"Id"=1074;"Logname"="System"} -ComputerName $Machine -MaxEvents 1
					$UnSuccessfullReboot = Get-WinEvent -FilterHashtable @{"Id"=41;"Logname"="System"} -ComputerName $Machine -MaxEvents 1
				}
				$Event = IF($SuccessfullReboot.TimeWritten -gt $UnSuccessfullReboot.Timewritten){$SuccessfullReboot;$Cleanboot = $True}ELSE{$UnSuccessfullReboot}
				$LastRebootTime = $Event.TimeGenerated
				$UpTime = New-TimeSpan -start $LastReboot T ime -end $(Get-Date)
				IF($CleanBoot){
					$Result = $Result + (New-Object PSObject -Property @{ #Build the object for return
						"Code" = $Event.ReplacementStrings[3]
						"Comment" = $Event.ReplacementStrings[5]
						"ComputerName" = $Machine.toupper()
						"LastBoot" = $LastRebootTime
						"Message" = $Event.Message
						"Process" = $Event.ReplacementStrings[0]
						"Reason" = $Event.ReplacementStrings[2]
						"Type" = $Event.ReplacementStrings[4]
						"UpTime" = $UpTime
						"User" = $Event.ReplacementStrings[6]
						"CleanBoot"  =  $True
					})
				}
				ELSE{
					$Result = $Result + (New-Object PSObject -Property @{ #Build the object for return
						"ComputerName" = $Machine.toupper()
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
