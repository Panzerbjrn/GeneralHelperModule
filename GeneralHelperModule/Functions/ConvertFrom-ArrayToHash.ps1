Function ConvertFrom-ArrayToHash($a){
	$Hash = @{}
	($a | Get-Member | Where-Object {$_.Membertype -eq "NoteProperty"}).name | ForEach-Object {$Hash.$($_) = $A.$($_)}
	$hash
}
