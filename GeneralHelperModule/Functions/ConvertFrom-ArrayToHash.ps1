Function ConvertFrom-ArrayToHash($a) {
    <#
		.SYNOPSIS
			Converts an object's properties to a hashtable

		.DESCRIPTION
			This function takes an object and converts all of its NoteProperty members into a hashtable where property names become keys and property values become hashtable values.

		.PARAMETER a
			The object to convert to a hashtable

		.EXAMPLE
			$obj = [PSCustomObject]@{Name="John"; Age=30}
			ConvertFrom-ArrayToHash -a $obj

			Converts the custom object to a hashtable with keys "Name" and "Age"

	#>
    [CmdletBinding()]
    $Hash = @{}
    ($a | Get-Member | Where-Object { $_.Membertype -eq "NoteProperty" }).name | ForEach-Object { $Hash.$($_) = $A.$($_) }
    $hash
}


