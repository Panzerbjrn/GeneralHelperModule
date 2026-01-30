BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Get-DataTypeName' -Tag 'Get-DataTypeName', 'Unit' {

  Context 'When checking string data types' {

    It 'Should return String for a string value' {

      $result = Get-DataTypeName -Value "Hello World"
      $result | Should -Be 'String'
    }

    It 'Should return String for an empty string' {

      $result = Get-DataTypeName -Value ""
      $result | Should -Be 'String'
    }

  }

  Context 'When checking numeric data types' {

    It 'Should return Int32 for an integer' {

      $result = Get-DataTypeName -Value 42
      $result | Should -Be 'Int32'
    }

    It 'Should return Double for a double value' {

      $result = Get-DataTypeName -Value 3.14
      $result | Should -Be 'Double'
    }

    It 'Should return Int64 for a long integer' {

      [Int64]$longValue = 9223372036854775807
      $result = Get-DataTypeName -Value $longValue
      $result | Should -Be 'Int64'
    }

  }

  Context 'When checking boolean data types' {

    It 'Should return Boolean for $true' {

      $result = Get-DataTypeName -Value $true
      $result | Should -Be 'Boolean'
    }

    It 'Should return Boolean for $false' {

      $result = Get-DataTypeName -Value $false
      $result | Should -Be 'Boolean'
    }

  }

  Context 'When checking array data types' {

    It 'Should return Object[] for an array' {

      $array = @(1, 2, 3)
      $result = Get-DataTypeName -Value $array
      $result | Should -Be 'Object[]'
    }

    It 'Should return Byte[] for a byte array' {

      $byteArray = [System.Byte[]]::new(4)
      $result = Get-DataTypeName -Value $byteArray
      $result | Should -Be 'Byte[]'
    }

  }

  Context 'When checking DateTime data types' {

    It 'Should return DateTime for a date object' {

      $date = Get-Date
      $result = Get-DataTypeName -Value $date
      $result | Should -Be 'DateTime'
    }

  }

  Context 'When checking hashtable data types' {

    It 'Should return Hashtable for a hashtable' {

      $hash = @{ Key = "Value" }
      $result = Get-DataTypeName -Value $hash
      $result | Should -Be 'Hashtable'
    }

  }

}

