Function Get-Parameter {
    <#
		.SYNOPSIS
			Gets parameter information for a PowerShell command

		.DESCRIPTION
			This function retrieves all parameters for a specified PowerShell command and returns their names and whether they are mandatory.
			Useful for analyzing command structure and requirements.

		.PARAMETER CommandName
			The name of the PowerShell command to analyze

		.EXAMPLE
			Get-Parameter -CommandName "Get-Process"

			Returns all parameters for Get-Process with their mandatory status

		.EXAMPLE
			Get-Parameters -CommandName "Write-Host"

			Using the alias to get parameter information for Write-Host

	#>
    [CmdletBinding()]
    [Alias('Get-Parameters')]
    param (
        [Parameter(Mandatory)]
        [string]$CommandName
    )

    # Get the command object
    $command = Get-Command -Name $CommandName -ErrorAction Stop

    # Process each parameter
    $parameters = ForEach ($key in $command.Parameters.Keys) {
        $parameter = $command.Parameters[$key]
        $MandatoryAttribute = $parameter.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }
        [PSCustomObject]@{
            Name      = $key
            Mandatory = $MandatoryAttribute.Mandatory
        }
    }

    # Return the result
    $parameters
}


