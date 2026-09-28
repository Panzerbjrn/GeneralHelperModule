Function Test-PendingReboot {
    <#
		.SYNOPSIS
			Tests if the system has a pending reboot

		.DESCRIPTION
			This function checks multiple registry keys and WMI to determine if Windows has a pending reboot.
			It checks Component Based Servicing, Windows Update, Session Manager, and SCCM client if available.

		.EXAMPLE
			Test-PendingReboot

			Returns $true if a reboot is pending, $false otherwise

		.EXAMPLE
			IF(Test-PendingReboot) { Restart-Computer }

			Restarts the computer if a reboot is pending

	#>


	# .NET alternative: [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending')
    IF(Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue) { return $True }
	# .NET alternative: [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired')
    IF(Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue) { return $True }
    IF(Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -ErrorAction SilentlyContinue) { return $True }
    TRY{
        $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
        $status = $util.DetermineIfRebootPending()
        IF(($status -ne $Null) -and $status.RebootPending) { return $True }
    }CATCH{ Write-Error "" }
    return $False
}

