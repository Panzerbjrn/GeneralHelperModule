function Get-Parameters {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$CommandName
    )

    # Get the command object
    $command = Get-Command -Name $CommandName -ErrorAction Stop

    # Process each parameter
    $parameters = foreach ($key in $command.Parameters.Keys) {
        $parameter = $command.Parameters[$key]
        $mandatoryAttribute = $parameter.Attributes | Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }
        [PSCustomObject]@{
            Name      = $key
            Mandatory = $mandatoryAttribute.Mandatory
        }
    }

    # Return the result
    $parameters
}
