Function Test-PendingReboot
{
	IF (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue) { return $True }
	IF (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue) { return $True }
	IF (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -ErrorAction SilentlyContinue) { return $True }
	Try
	{
		$util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
		$status = $util.DetermineIfRebootPending()
		IF(($status -ne $Null) -and $status.RebootPending){return $True}
	}catch{Write-Error ""}
	return $False
}