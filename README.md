TwitchStreamLister
==================

# About
This is a small PowerShell module to list the top 25 live streams on Twitch to a given game.
Afterwards you're able to launch a stream just using it's number using an installed [LiveStreamer](https://github.com/chrippa/livestreamer) instance.

# Requirements
This script requires at least PowerShell 4.0 (due to the usage of `Invoke-RestMethod`).

# Installation
Make sure you sign the script or enable unrestricted script access. To do this, start PowerShell as Administrator and execute `Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Confirm`.

After this, open PowerShell and execute `(new-object Net.WebClient).DownloadString("https://github.com/ElectronicWar/twitchstreamlister/blob/master/GetTwitchStreamLister.ps1") | iex`.
This will automatically download TwitchStreamLister as module into your profile.

# Usage
Just type `Watch-TwitchStreams`.

# Modification
TwitchStreamLister is installed into `%UserProfile%\Documents\WindowsPowerShell\Modules\TwitchStreamLister\TwitchStreamLister.psm1`.

To change the listed game, edit the `Invoke-TwitchGetStreams` call at the end or remove the paramter completely for interative input. The used stream quality can be changed in `Invoke-TwitchWatchStream` as first parameter.
