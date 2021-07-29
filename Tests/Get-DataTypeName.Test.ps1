$BufferSize = 4
$DataTypeName = [System.Byte[]]::new($BufferSize)
$RandomSeed = [System.Random]::new()
$RandomSeed.NextBytes($DataTypeName)

$TestData =	@(
	@{
		"TestValue" = "Value One"
		"TestType" = "String"
	},
	@{
		"TestValue" = 2
		"TestType" = "int32"
	},
	@{
		"TestValue" = $DataTypeName
		"TestType" = "Byte[]"
	},
	@{
		"TestValue" = Get-Date
		"TestType" = "DateTime"
	}
) 
	
Describe "Test some Values" {
	It "Test if <TestValue> is a <TestType> Object"	-TestCase $TestData {
		param($TestValue, $TestType)
		get-DataTypeName -value $TestValue | Should -Be $TestType
	}
}

$TestParameters = @(
	@{
		"TestParam" = "Value"
		"Mandatory" = $True
	}
)

Describe "Test some Parameters" {
	It "Test if <TestParam> is a Mandatory Object" -TestCase $TestParameters {
		param($TestParam, $Mandatory)
		(Get-Command -Name Get-DataTypeName).Parameters["$TestParam"].Attributes.Mandatory | Should -Be $Mandatory
	}
}
