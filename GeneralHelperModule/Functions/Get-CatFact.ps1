Function Get-CatFact {
  param(
    [string]$open="It is now time for a cat fact....",
    [string]$fact=(((Invoke-WebRequest -Uri     https://catfact.ninja/fact).content|ConvertFrom-Json).fact),
    [int]$rate = 2
  )
    $speak ="$open $fact"
    $v=New-Object -com SAPI.SpVoice
    $voice =$v.getvoices()|where {$_.id -like "*ZIRA*"}
    $v.voice= $voice
    $v.rate=$rate
    [void]$v.speak($speak)
}
#catfact