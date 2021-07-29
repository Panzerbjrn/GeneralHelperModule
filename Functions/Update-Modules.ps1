Function Update-Modules
{
	$CName = $ENV:ComputerName
	Write-Verbose "$($CName)"
	Write-Host "Update-Modules"
	IF(!(Test-Path -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules)){New-Item -ItemType "Directory" -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules -Force}
	IF(!(Test-Path -Path C:\Users\Petersson_L_a\Documents\PowerShell\Modules)){New-Item -ItemType "Directory" -Path C:\Users\Petersson_L_a\Documents\PowerShell\Modules -Force}
	$AdminModules = @(
	"BrewinDolphinModules"
	"LarsModulesADTools"
	"LarsModulesGeneric"
	"LarsModulesPowerCLIModules"
	"LarsModulesYoinked"
	"LarsModuleTFTD"
	)
	$RegularModules = @(
	"BrewinDolphinModules"
	"LarsModulesADTools"
	"LarsModulesArch"
	"LarsModulesAWSS3"
	"LarsModulesAzure"
	"LarsModulesGeneric"
	"LarsModulesPowerCLIModules"
	"LarsModulesYoinked"
	"LarsModulesYoinkedAzure"
	"LarsModuleTFTD"
	)

	IF ($CName -eq "UKL8CTLTJVBB8Y2")
	{
		$AdminModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules\$_" /mir /R:1 /W:1}
		$AdminModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "C:\Users\Petersson_L_a\Documents\PowerShell\Modules\$_" /mir /R:1 /W:1}
		$RegularModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "\\BD-BS01\data$\users\petersson_l\Documents\WindowsPowerShell\Modules\$_" /mir /R:1 /W:1}
		$RegularModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "\\UKL8CTLTJVBB8Y2\C$\Users\petersson_l\Documents\WindowsPowerShell\Modules\$_" /mir /R:1 /W:1}
		$RegularModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "\\BD-BS01\data$\users\petersson_l\Documents\PowerShell\Modules\$_" /mir /R:1 /W:1}
		$RegularModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "\\UKL8CTLTJVBB8Y2\C$\Users\petersson_l\Documents\PowerShell\Modules\$_" /mir /R:1 /W:1}
	}
		ELSEIF ($CName -eq "VM-W10VDI-SI")
	{
		Write-Host "Updating VDI"
		$AdminModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules\$_" /mir /R:1 /W:1}
		$AdminModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "C:\Users\Petersson_L_a\Documents\PowerShell\Modules\$_" /mir /R:1 /W:1}
	}
		ELSE
	{
		Write-Host "Updating ELSE"
		$AdminModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules\$_" /mir /R:1 /W:1}
		$AdminModules | ForEach-Object {Robocopy "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules\$_" "C:\Users\Petersson_L_a\Documents\PowerShell\Modules\$_" /mir /R:1 /W:1}
	}
}
