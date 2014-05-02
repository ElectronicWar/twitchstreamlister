<#
.SYNOPSIS
    TwitchStreamLister module install script.
    URL: https://github.com/ElectronicWar/twitchstreamlister
    Script copied from... *caugh* based on http://psget.net/GetPsGet.ps1 by Mike Chaliy, thanks ~(￣ー￣)~
#>
#requires -Version 4.0

function Install-TwitchStreamLister {
    $ModulePaths = @($Env:PSModulePath -split ';')
    # $TwitchStreamListerDestinationModulePath is mostly needed for testing purposes, 
    if ((Test-Path -Path Variable:TwitchStreamListerDestinationModulePath) -and $TwitchStreamListerDestinationModulePath) {
        $Destination = $TwitchStreamListerDestinationModulePath
        if ($ModulePaths -notcontains $Destination) {
            Write-Warning 'TwitchStreamLister install destination is not included in the PSModulePath environment variable'
        }
    } else {
        $ExpectedUserModulePath = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules
        $Destination = $ModulePaths | Where-Object { $_ -eq $ExpectedUserModulePath}
        if (-not $Destination) {
            $Destination = $ModulePaths | Select-Object -Index 0
        }
    }

    $scriptUrl = "https://raw.githubusercontent.com/ElectronicWar/twitchstreamlister/master/TwitchListStreams.psm1"
    
    New-Item ($Destination + "\TwitchListStreams\") -ItemType Directory -Force | out-null
    Write-Host Downloading TwitchStreamLister from $scriptUrl
    $client = (New-Object Net.WebClient)
    $client.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $client.DownloadFile($scriptUrl, $Destination + "\TwitchListStreams\TwitchListStreams.psm1")

    $executionPolicy  = (Get-ExecutionPolicy)
    $executionRestricted = ($executionPolicy -eq "Restricted")
    if ($executionRestricted){
        Write-Warning @"
Your execution policy is $executionPolicy, this means you will not be able import or use any scripts including modules.
To fix this change your execution policy to something like RemoteSigned.

        PS> Set-ExecutionPolicy RemoteSigned

For more information execute:
        
        PS> Get-Help about_execution_policies

"@
    }

    Write-Host "TwitchStreamLister is installed and ready to use" -Foreground Green
    Write-Host @"
USAGE:
    PS> Watch-TwitchStreams

For more details visit https://github.com/ElectronicWar/twitchstreamlister
"@
}

Install-TwitchStreamLister