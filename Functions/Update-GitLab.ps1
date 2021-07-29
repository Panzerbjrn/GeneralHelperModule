Function Update-GitLab{
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		[Alias('Repo')]
		[ValidateNotNullOrEmpty()]
		[string[]]$Basename,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string[]]$CommitMessage,

		[Switch]$Ask
	)

	BEGIN{
		Write-Verbose "#################################################################"
		Write-Verbose "Beginning $($MyInvocation.MyCommand.Name) on $($ENV:ComputerName) @ $(Get-Date -Format "yyyy.MM.dd HH:mm:ss")" -Verbose
		Write-Verbose "#################################################################"
		$Path = "C:\Dropbox\__IHSMarkit\__GitLab"
	}

	PROCESS{
		
	IF ($Ask){
		$Menu = @{}
		for ($i=1;$i -le $(Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name).count; $i++){
			Write-Host "$i. $((Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name)[$i-1])"
			$Menu.Add($i,($(Get-ChildItem -Path $Path -Directory | Select-Object -ExpandProperty Name)[$i-1]))
			}
		[int]$Choice = Read-Host 'Enter selection'
		[string]$Basename = $Menu.Item($Choice)
		Write-Verbose "$Basename was chosen"
	}
		
		
		Write-Verbose "Processing $($MyInvocation.Mycommand)"
		Set-Location C:\Dropbox\__IHSMarkit\__GitLab\$BaseName\
		git add .
		git commit -m "$CommitMessage"
		git push

	}
	END{
		Write-Verbose "Ending $($MyInvocation.Mycommand)"
	}
}
