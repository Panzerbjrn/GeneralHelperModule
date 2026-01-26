function Test-JobLoop {
    <#
	.SYNOPSIS
		This function will loop through a job and return to the console when the job is done.

	.DESCRIPTION
		This function will loop through a job and return to the console when the job is done.

	.PARAMETER JobID
		This should be the ID of the job to monitor.

	.INPUTS
		None

	.OUTPUTS
		This Outputs a simple Done when it is done.

	.NOTES
		Version:			1.0
		Author:			Lars Petersson
		Creation Date:	2019.02.27
		Purpose/Change:	Initial script development

	.EXAMPLE
		Test-JobLoop -JobID 3

	.EXAMPLE
		Test-JobLoop -JobID $StartJob.id
	#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True, ValueFrompipeline = $True)][string]$JobID
    )

    do {
        $JobLoop = Get-Job -Id $JobID
        Write-Verbose "$($JobLoop)"
        if ($JobLoop.State -eq "Running") { "Cogitating"; Sleep 5 }
    }
    while ($JobLoop.State -eq "Running")
    "Done"
    $JobLoop
}
