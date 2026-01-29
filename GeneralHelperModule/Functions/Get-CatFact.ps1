Function Get-CatFact {
    <#
		.SYNOPSIS
			Retrieves a random cat fact and reads it aloud using text-to-speech

		.DESCRIPTION
			This function fetches a random cat fact from catfact.ninja API and uses Windows SAPI text-to-speech to read it aloud using the Zira voice.

		.PARAMETER open
			The opening phrase to speak before the cat fact. Default is "It is now time for a cat fact...."

		.PARAMETER Fact
			The cat fact to speak. Default fetches a random fact from catfact.ninja API

		.PARAMETER rate
			The speech rate for the text-to-speech voice. Default is 2

		.EXAMPLE
			Get-CatFact

			Retrieves and speaks a random cat fact with default settings

		.EXAMPLE
			Get-CatFact -open "Here's something interesting" -rate 3

			Speaks a cat fact with a custom opening phrase at a faster speech rate

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


