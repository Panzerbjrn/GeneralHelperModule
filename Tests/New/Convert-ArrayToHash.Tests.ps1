BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Convert-ArrayToHash' -Tag 'Convert-ArrayToHash', 'Unit' {

  Context 'When converting PSCustomObject to hashtable' {

    It 'Should convert object with properties to hashtable' {

      $obj = [PSCustomObject]@{Name = "John"; Age = 30}
      $result = Convert-ArrayToHash -a $obj
      $result | Should -BeOfType [System.Collections.Hashtable]
    }

    It 'Should preserve property names as keys' {

      $obj = [PSCustomObject]@{Name = "John"; Age = 30}
      $result = Convert-ArrayToHash -a $obj
      $result.ContainsKey('Name') | Should -Be $true
      $result.ContainsKey('Age') | Should -Be $true
    }

    It 'Should preserve property values' {

      $obj = [PSCustomObject]@{Name = "John"; Age = 30}
      $result = Convert-ArrayToHash -a $obj
      $result['Name'] | Should -Be "John"
      $result['Age'] | Should -Be 30
    }

    It 'Should handle objects with multiple properties' {

      $obj = [PSCustomObject]@{
        FirstName = "John"
        LastName  = "Doe"
        Age       = 30
        City      = "New York"
      }
      $result = Convert-ArrayToHash -a $obj
      $result.Count | Should -Be 4
      $result['FirstName'] | Should -Be "John"
      $result['City'] | Should -Be "New York"
    }

  }

  Context 'When converting empty or simple objects' {

    It 'Should handle objects with no NoteProperties' {

      $obj = "Simple String"
      $result = Convert-ArrayToHash -a $obj
      $result | Should -BeOfType [System.Collections.Hashtable]
    }

  }

}

