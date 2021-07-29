Function Test-ConnectivityStatus
{
<#
	.SYNOPSIS
		This function will test for user rights to create VMs

	.DESCRIPTION
		This function will test for user rights to create VMs

	.PARAMETER ServerCloud
		The VMM cloud the VM should be placed in

	.PARAMETER Domain
		The Domain the VM should be placed in

	.PARAMETER VMMServer
		The VMM Server to use.

	.INPUTS
		Input is the name to test against

	.OUTPUTS
		This will output either True or False

	.NOTES
		Version:			0.1
		Author:				Lars Panzerbjrn
		Creation Date:		2019.05.07
		Purpose/Change: Initial script development
#>
	[CmdletBinding(PositionalBinding=$False)]
	Param
	(
		[Parameter(Mandatory=$True,ValueFromPipelineByPropertyName=$True)]
		[string[]]$ComputerName
	)
	BEGIN
	{
		$ErrorActionPreference = "STOP"
		$i = 0
		$MaxJobs = 10
		$Scriptblock = {
			Param 
			(
				[string]$Server
			)
			Try
			{
				IF ([System.Net.Dns]::GetHostEntry($Server).HostName)
				{
					IF (Test-Connection -ComputerName $Server -Count 1 -Quiet)
					{
						$HashTable += @(
						[pscustomobject]@{
							Server = $Server
							Up = $True
							}
						)
					}
					ELSE
					{
						$HashTable += @(
						[pscustomobject]@{
							Server = $Server
							Up = $False
							}
						)
					}
				}
				IF (!([System.Net.Dns]::GetHostEntry($Server).HostName))
				{
					$HashTable += @(
					[pscustomobject]@{
						Server = $Server
						Exist = $False
						}
					)
				}
			}
			Catch [System.Management.Automation.MethodInvocationException]
			{
				$HashTable += @(
				[pscustomobject]@{
					Server = $Server
					Exist = $False
					}
				)
			}
			Catch
			{
				$HashTable += @(
				[pscustomobject]@{
					Server = $Server
					Up = $False
					}
				)
			}
			$HashTable
		}
	}
	Process
	{
		ForEach ($Server in $ComputerName)
		{
			$i++
			Write-Verbose "$($i): $($Server)" -verbose
			$Running = (Get-Job -State Running|Measure-Object)
			While($Running.Count -ge $MaxJobs)
			{
				Write-Verbose "$($Running.Count) jobs are running"
				$Running = (Get-Job -State Running|Measure-Object)
				Start-Sleep -Milliseconds 500
			}
			Start-Job -ScriptBlock $ScriptBlock -ArgumentList $Server | Out-Null
		}
	}
	END
	{
		DO {
			Write-Verbose "There are $((Get-Job -State Running|Measure-Object).count) jobs running" -Verbose
			IF(Get-Job -State Running) {Write-Verbose "Cogitating";Start-Sleep -s 5}
			}
			While (Get-Job -State Running)
		Get-Job | Wait-job -Timeout 600 | Receive-Job
	}
}