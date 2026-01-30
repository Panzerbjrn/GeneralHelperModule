BeforeAll {

  Import-Module "$PSScriptRoot\..\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force

}

Describe 'Format-DiskSize' -Tag 'Format-DiskSize', 'Unit' {

  Context 'When formatting sizes in Petabytes' {

    It 'Should format 1PB correctly' {

      $result = Format-DiskSize -size 1PB
      $result | Should -Be '1PB'
    }

    It 'Should format 1.5PB correctly' {

      $result = Format-DiskSize -size 1.5PB
      $result | Should -Be '1.5PB'
    }

    It 'Should format 2.75PB correctly' {

      $result = Format-DiskSize -size 2.75PB
      $result | Should -Be '2.8PB'
    }

  }

  Context 'When formatting sizes in Terabytes' {

    It 'Should format 1TB correctly' {

      $result = Format-DiskSize -size 1TB
      $result | Should -Be '1TB'
    }

    It 'Should format 500GB as 0.5TB' {

      $result = Format-DiskSize -size 512GB
      $result | Should -Be '512GB'
    }

    It 'Should format 1.25TB correctly' {

      $result = Format-DiskSize -size 1.25TB
      $result | Should -Be '1.3TB'
    }

  }

  Context 'When formatting sizes in Gigabytes' {

    It 'Should format 1GB correctly' {

      $result = Format-DiskSize -size 1GB
      $result | Should -Be '1GB'
    }

    It 'Should format 1073741824 bytes as 1GB' {

      $result = Format-DiskSize -size 1073741824
      $result | Should -Be '1GB'
    }

    It 'Should format 2.5GB correctly' {

      $result = Format-DiskSize -size 2.5GB
      $result | Should -Be '2.5GB'
    }

  }

  Context 'When formatting sizes in Megabytes' {

    It 'Should format 1MB correctly' {

      $result = Format-DiskSize -size 1MB
      $result | Should -Be '1MB'
    }

    It 'Should format 1048576 bytes as 1MB' {

      $result = Format-DiskSize -size 1048576
      $result | Should -Be '1MB'
    }

    It 'Should format 500MB correctly' {

      $result = Format-DiskSize -size 500MB
      $result | Should -Be '500MB'
    }

  }

  Context 'When formatting sizes in Kilobytes' {

    It 'Should format 1KB correctly' {

      $result = Format-DiskSize -size 1KB
      $result | Should -Be '1KB'
    }

    It 'Should format 1024 bytes as 1KB' {

      $result = Format-DiskSize -size 1024
      $result | Should -Be '1KB'
    }

    It 'Should format 512KB correctly' {

      $result = Format-DiskSize -size 512KB
      $result | Should -Be '512KB'
    }

  }

  Context 'When formatting sizes in Bytes' {

    It 'Should format 512 bytes correctly' {

      $result = Format-DiskSize -size 512
      $result | Should -Be '512B'
    }

    It 'Should format 1 byte correctly' {

      $result = Format-DiskSize -size 1
      $result | Should -Be '1B'
    }

    It 'Should format 0 bytes correctly' {

      $result = Format-DiskSize -size 0
      $result | Should -Be '0B'
    }

  }

}

