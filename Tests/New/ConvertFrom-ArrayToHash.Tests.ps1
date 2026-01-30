BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'ConvertFrom-ArrayToHash' -Tag 'ConvertFrom-ArrayToHash', 'Unit' {

  Context 'When converting PSCustomObject to hashtable' {

    It 'Should convert object with properties to hashtable' {

      $obj = [PSCustomObject]@{Name = "Jane"; Age = 25}
      $result = ConvertFrom-ArrayToHash -a $obj
      $result | Should -BeOfType [System.Collections.Hashtable]
    }

    It 'Should preserve property names as keys' {

      $obj = [PSCustomObject]@{Name = "Jane"; Age = 25}
      $result = ConvertFrom-ArrayToHash -a $obj
      $result.ContainsKey('Name') | Should -Be $true
      $result.ContainsKey('Age') | Should -Be $true
    }

    It 'Should preserve property values' {

      $obj = [PSCustomObject]@{Name = "Jane"; Age = 25}
      $result = ConvertFrom-ArrayToHash -a $obj
      $result['Name'] | Should -Be "Jane"
      $result['Age'] | Should -Be 25
    }

    It 'Should handle objects with multiple properties' {

      $obj = [PSCustomObject]@{
        FirstName = "Jane"
        LastName  = "Smith"
        Age       = 25
        City      = "Boston"
      }
      $result = ConvertFrom-ArrayToHash -a $obj
      $result.Count | Should -Be 4
      $result['FirstName'] | Should -Be "Jane"
      $result['City'] | Should -Be "Boston"
    }

  }

  Context 'When converting empty or simple objects' {

    It 'Should handle objects with no NoteProperties' {

      $obj = "Simple String"
      $result = ConvertFrom-ArrayToHash -a $obj
      $result | Should -BeOfType [System.Collections.Hashtable]
    }

  }

}

