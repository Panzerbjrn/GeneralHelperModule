BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-CatFact' -Tag 'Get-CatFact', 'Unit' {

  Context 'When retrieving cat facts' {

    It 'Should not throw an error with custom fact provided' {

      { Get-CatFact -Fact "Cats are amazing" -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should accept custom opening phrase' {

      { Get-CatFact -open "Here is a fact" -Fact "Cats have nine lives" -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Should accept custom speech rate' {

      { Get-CatFact -rate 5 -Fact "Cats purr" -ErrorAction Stop } | Should -Not -Throw
    }

  }

}

