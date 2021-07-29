function Enable-RemoteDesktop
 {
     [CmdletBinding()]
     param
     (
         [Parameter(Mandatory)]
         [string]$ComputerName
     )
     $sb = { Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name 'fDenyTSConnections' -Value 0;
 Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'
 }
     Invoke-Command -ComputerName $ComputerName -ScriptBlock $sb
 }