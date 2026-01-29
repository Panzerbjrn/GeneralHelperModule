Function Enable-RDPAccess {
    <#
		.SYNOPSIS
			Enables Remote Desktop Protocol (RDP) access on the local machine

		.DESCRIPTION
			This function enables RDP by modifying registry settings, enabling the Remote Desktop firewall rules, and requiring Network Level Authentication.
			Performs three actions: disables fDenyTSConnections, enables Remote Desktop firewall rules, and enables NLA.

		.EXAMPLE
			Enable-RDPAccess

			Enables RDP access on the local computer with Network Level Authentication

	#>
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-Name "fDenyTSConnections" -Value 0;
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1
}

