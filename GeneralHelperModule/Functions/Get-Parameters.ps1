function Get-Parameters {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$CommandName
    )

    # Get the command object
    $command = Get-Command -Name $CommandName -ErrorAction Stop

    # Process each parameter
    $parameters = foreach ($key in $command.Parameters.Keys) {
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
