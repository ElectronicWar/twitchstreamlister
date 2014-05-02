# TwitchStreamLister
# Helping hand for LiveStreamer users
#
# Version r1 (2014-05-02)
#
# TwitchStreamLister is available under The MIT License (MIT). See included LICENSE.
# Copyright (c) 2014 Manuel "ElectronicWar" Kröber <manuel.kroeber@gmail.com>

function Invoke-TwitchGetStreams {
    Param (
        [Parameter(Mandatory=$True)]
        [string]$gameName
    )

    $clientID = "sw19g2vrz9nkugaviab9xbk6w7ehxxh"
    $userAgent = "PowerShell StreamLister"
    $game = [System.Web.HttpUtility]::UrlEncode($gameName);
    $url = "https://api.twitch.tv/kraken/streams?game=" + $game
    $headers = @{"Client-ID" = $ClientID}
    
    Write-Host ("Retrieving '" + $gameName + "' stream list from Twitch.tv API...")
    $apiResult = Invoke-RestMethod -Uri $url -Method Get -UserAgent $userAgent -Headers $headers
    return $apiResult.streams
}

function Invoke-TwitchListStreams {
    Param (
        [Parameter(Mandatory=$True)]
        [PSObject]$streamList
    )

    $streamNum = 0
    foreach ($stream in $streamList) {
        $streamNum++
        Write-Host -NoNewLine ($streamNum.ToString().PadLeft(2, "0") + ": ")
        Write-Host -NoNewLine -ForegroundColor "Green" ($stream.channel.display_name.PadRight(25, " "))
        Write-Host $stream.viewers "Viewers"
    }
}

function Invoke-TwitchWatchStream {
    Param (
        [Parameter(Mandatory=$True, Position=0)]
        [PSObject]$streamList,

        [Parameter(Mandatory=$True, Position=1, HelpMessage="Please enter the stream list number you want to watch.")]
        [Int32]$streamNum
    )

    if ($streamNum -gt 0) {
        Write-Host ("Starting stream #" + $streamNum + " (" + $streamList[$streamNum-1].channel.display_name + ") with LiveStreamer using 'best' setting.")
        livestreamer $streamList[$streamNum-1].channel.url best
    } else {
        Write-Host "Invalid stream number."
    }
}

$streams = Invoke-TwitchGetStreams("League of Legends")
Write-Host "Top 25 Live Streams. Enter a number to watch it's associated stream."
Invoke-TwitchListStreams($streams)
Invoke-TwitchWatchStream($streams)