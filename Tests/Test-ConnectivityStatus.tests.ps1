BeforeAll {
    Import-Module "$PSScriptRoot\..\GeneralHelperModule\GeneralHelperModule.psd1" -Force
}

Describe 'Test-ConnectivityStatus' {

    It 'should return $true when the computer is online' {
        Mock 'Test-ConnectivityStatus' -MockWith { $True }
        Test-ConnectivityStatus -ComputerName GMPR-WIKAPP01 | Should -Be $true
    }

    It 'should return $False when the computer is offline' {
        Mock 'Test-ConnectivityStatus' -MockWith { $False }
        Test-ConnectivityStatus -ComputerName GMPR-WIKAPP011234 | Should -Be $false
    }
}
