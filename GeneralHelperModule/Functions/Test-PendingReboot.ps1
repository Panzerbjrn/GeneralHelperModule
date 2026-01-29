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
			if (Test-PendingReboot) { Restart-Computer }

			Restarts the computer if a reboot is pending

	#>


    if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue) { return $True }
    if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue) { return $True }
    if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -ErrorAction SilentlyContinue) { return $True }
    try {
        $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
        $status = $util.DetermineIfRebootPending()
        if (($status -ne $Null) -and $status.RebootPending) { return $True }
    }
    catch { Write-Error "" }
    return $False
}

