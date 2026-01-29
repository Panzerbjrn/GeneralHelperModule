Function Test-JobLoop {
    <#
		.SYNOPSIS
			Monitors a PowerShell job and waits for completion

		.DESCRIPTION
			This function will loop through a PowerShell job and monitor its status, returning to the console when the job is done.
			It checks the job status every 5 seconds and provides feedback during execution.

		.PARAMETER JobID
			The ID of the PowerShell job to monitor (accepts pipeline input)

		.EXAMPLE
			Test-JobLoop -JobID 3

			Monitors job with ID 3 until completion

		.EXAMPLE
			$job = Start-Job -ScriptBlock { Start-Sleep 30 }
			Test-JobLoop -JobID $job.id

			Starts a background job and monitors it until completion

		.INPUTS
			String (Job ID)

		.OUTPUTS
			Outputs "Cogitating" during execution and "Done" when complete, followed by the job object

		.NOTES
			Author:			Lars Petersson
			Creation Date:	2019.02.27

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

