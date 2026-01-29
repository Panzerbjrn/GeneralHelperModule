Describe "Format-DiskSize" {
    Context "When size is greater than or equal to 1PB" {
        It "Formats size correctly" {
            $result = Format-DiskSize 1208925819614720  # 1.1PB in bytes
            $result | Should -Be "1.1PB"
        }
    }

    Context "When size is greater than or equal to 1TB" {
        It "Formats size correctly" {
            $result = Format-DiskSize 1099511627776  # 1TB in bytes
            $result | Should -Be "1TB"
        }
    }

    Context "When size is greater than or equal to 1GB" {
        It "Formats size correctly" {
            $result = Format-DiskSize 1073741824  # 1GB in bytes
            $result | Should -Be "1GB"
        }
    }

    Context "When size is greater than or equal to 1MB" {
        It "Formats size correctly" {
            $result = Format-DiskSize 1048576  # 1MB in bytes
            $result | Should -Be "1MB"
        }
    }

    Context "When size is greater than or equal to 1KB" {
        It "Formats size correctly" {
            $result = Format-DiskSize 1024  # 1KB in bytes
            $result | Should -Be "1KB"
        }
    }

    Context "When size is less than 1KB" {
        It "Formats size correctly" {
            $result = Format-DiskSize 512  # Less than 1KB in bytes
            $result | Should -Be "512B"
        }
    }
}


