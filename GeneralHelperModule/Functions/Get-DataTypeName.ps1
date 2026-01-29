Function Get-DataTypeName {
    <#
		.SYNOPSIS
			Gets the data type name of a value

		.DESCRIPTION
			This function returns the .NET type name of any object or value passed to it.
			Useful for determining the actual type of variables and objects.

		.PARAMETER Value
			The value or object whose type name should be returned

		.EXAMPLE
			Get-DataTypeName -Value "Hello"

			Returns "String"

		.EXAMPLE
			Get-DataTypeName -Value 42

			Returns "Int32"

		.EXAMPLE
			$array = @(1,2,3)
			Get-DataTypeName -Value $array

			Returns "Object[]"

	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]$Value
    )
    return ($value.getType()).name
}


