Function Connect-SCOM {

Try{IF (!(Get-SCManagementGroupConnection)) {New-SCManagementGroupConnection -ComputerName SCOM2012}}catch{$_|Get-ErrorInfo}

}