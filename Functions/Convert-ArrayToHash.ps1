Function Convert-ArrayToHash($a)
{
    $Hash = @{}
    ($a | GM | Where-Object {$_.Membertype -eq "NoteProperty"}).name | ForEach-Object {$Hash.$($_) = $A.$($_)}
	$hash
}