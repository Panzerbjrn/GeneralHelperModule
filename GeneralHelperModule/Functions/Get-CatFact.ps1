Function Get-CatFact {
    <#
		.SYNOPSIS
			Describe the function here

		.DESCRIPTION
			Describe the function in more detail

		.EXAMPLE
			Give an example of how to use it

  #>
    [CmdletBinding()]
    param(
        [string]$open = "It is now time for a cat fact....",
        [string]$Fact = (((Invoke-WebRequest -Uri https://catfact.ninja/fact).content | ConvertFrom-Json).fact),
        [int]$rate = 2
    )
    $speak = "$open $Fact"
    $v = New-Object -com SAPI.SpVoice
    $voice = $v.getvoices() | where-object { $_.id -like "*ZIRA*" }
    $v.voice = $voice
    $v.rate = $rate
    [void]$v.speak($speak)
}


