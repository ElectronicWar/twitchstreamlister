<#
.SYNOPSIS
    TwitchStreamLister, a helping hand for LiveStreamer users.
.DESCRIPTION
    Help can be found in README.md
    TwitchStreamLister is available under The MIT License (MIT). See included LICENSE.
    Copyright (c) 2014 Manuel "ElectronicWar" Kröber <manuel.kroeber@gmail.com>
.NOTES
    Author:     Manuel "ElectronicWar" Kroeber <manuel.kroeber@gmail.com>
    Version:    r3 (2014-05-02)
    License:    MIT
.LINK
    https://github.com/ElectronicWar/twitchstreamlister
#>
#requires -Version 4.0

Add-Type -AssemblyName System.Web

function Invoke-TwitchApi {
    Param (
        [Parameter(Mandatory=$True)]
        [String]$commandUrl
    )

    $clientID = "sw19g2vrz9nkugaviab9xbk6w7ehxxh"
    $userAgent = "PowerShell StreamLister"
    $game = [System.Web.HttpUtility]::UrlEncode($gameName);
    $apiUrl = "https://api.twitch.tv/kraken"
    $headers = @{"Client-ID" = $ClientID}
    
    $requestUrl = $apiUrl + $commandUrl

    $apiResult = Invoke-RestMethod -Uri $requestUrl -Method Get -UserAgent $userAgent -Headers $headers
    if ($apiResult) {
        return $apiResult
    } else {
        Write-Warning "Sorry, but there was a problem with the last twitch.tv API call."
        return
    }
}

function Invoke-TwitchGetStreams {
    Param (
        [Parameter(Mandatory=$True)]
        [String]$gameName
    )

    $game = [System.Web.HttpUtility]::UrlEncode($gameName);
    $command = "/streams?game=" + $game
    
    Write-Host ("Retrieving top 25 '" + $gameName + "' streams...")
    $gameStreams =  Invoke-TwitchApi -commandUrl $command
    if ($gameStreams) {
        return $gameStreams.streams
    } else {
        return
    }
}

function Invoke-TwitchGetTopGames {
    $game = [System.Web.HttpUtility]::UrlEncode($gameName);
    $command = "/games/top?limit=10"
    
    Write-Host ("Retrieving top live games...")
    $topGames =  Invoke-TwitchApi -commandUrl $command
    if ($topGames) {
        return $topGames.top
        $topGames.top
    } else {
        return
    }
}

function Invoke-TwitchListStreams {
    Param (
        [Parameter(Mandatory=$True)]
        [PSObject]$streamList
    )

    $nameLen = 0
    foreach ($stream in $streamList) {
        $len = $stream.channel.display_name.Length
        if ($len -gt $nameLen) { $nameLen = $len }
    }
    $nameLen++

    $streamNum = 0
    foreach ($stream in $streamList) {
        $streamNum++
        Write-Host -NoNewLine ($streamNum.ToString().PadLeft(2, "0") + ": ")
        Write-Host -NoNewLine -ForegroundColor "Green" ($stream.channel.display_name.PadRight($nameLen, " "))
        Write-Host $stream.viewers.ToString().PadLeft(6, " ") "Viewers"
    }
}

function Invoke-TwitchListGames {
    Param (
        [Parameter(Mandatory=$True)]
        [PSObject]$gameList
    )

    $gameLen = 0
    foreach ($game in $gameList) {
        $len = $game.game.name.Length
        if ($len -gt $gameLen) { $gameLen = $len }
    }
    $gameLen++

    $gameNum = 0
    foreach ($game in $gameList) {
        $gameNum++
        Write-Host -NoNewLine ($gameNum.ToString().PadLeft(2, "0") + ": ")
        Write-Host -NoNewLine -ForegroundColor "Green" ($game.game.name.PadRight($gameLen, " "))
        Write-Host $game.viewers.ToString().PadLeft(6, " ") "Viewers in" $game.channels "Channels"
    }
}

function Invoke-TwitchWatchStream {
    Param (
        [Parameter(Mandatory=$True)]
        [PSObject]$streamList,

        [Parameter(Mandatory=$True)]
        [Int32]$streamNumber,

        [Parameter(Mandatory=$False)]
        [String]$quality = "best"
    )

    if ($streamNumber -gt 0) {
        Write-Host (
            "Starting stream #" + $streamNumber +
            " (" + $streamList[$streamNumber-1].channel.display_name +
            ") with LiveStreamer using " +
            $quality + " quality setting."
        )
        livestreamer $streamList[$streamNumber-1].channel.url $quality
    } else {
        Write-Host "Invalid stream number."
    }
}

function Watch-TwitchStreams {
    if($PSVersionTable.PSVersion.Major -lt 4) {
        Write-Error "TwitchStreamLister requires PowerShell 4.0 or better; you have version $($Host.Version)"
        return
    }

    $games = Invoke-TwitchGetTopGames
    if (!$games) {
        Write-Warning "Something went wrong, please try again."
        return
    }
    
    Invoke-TwitchListGames($games)
    [Int32]$gameNumber = Read-Host "Enter game number to list it's top channels"
    $gameNumber--

    if ($gameNumber -lt 0) {
        Write-Host "Invalid number. Aborted."
        return
    }

    $streams = Invoke-TwitchGetStreams -game ($games[$gameNumber].game.name)
    if ($streams) {
        Invoke-TwitchListStreams -streamList $streams

        $streamNumber = Read-Host "Enter stream number to watch"
        Invoke-TwitchWatchStream -streamList $streams -streamNumber $streamNumber -quality "best"
    } else {
        Write-Warning "Unable to retrieve live stream list, please try again."
        return
    }
}