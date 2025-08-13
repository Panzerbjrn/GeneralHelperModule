describe 'Test-ConnectivityStatus' {

	it 'should return $true when the computer is online' {
		mock 'Test-ConnectivityStatus' -MockWith {	$True }
			Test-ConnectivityStatus -ComputerName GMPR-WIKAPP01 | should be $true
	}

	it 'should	return $False when the computer is offline' {
		mock 'Test-ConnectivityStatus' -MockWith {	$False }
			Test-ConnectivityStatus -ComputerName GMPR-WIKAPP011234 | should be $true
	}
}