TwitchStreamLister
==================

# About
This is a small PowerShell module to list the top 25 live streams on Twitch to a given game.
Afterwards you're able to launch a stream just using it's number using an installed [LiveStreamer](https://github.com/chrippa/livestreamer) instance.

![Console Output](https://raw.githubusercontent.com/ElectronicWar/twitchstreamlister/master/Screenshot.png)

# Requirements
This script requires at least PowerShell 4.0 (due to the usage of `Invoke-RestMethod`).
Make sure you sign the script or enable unrestricted script access. To do this, start PowerShell as Administrator and execute `Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Confirm`.

# Installation
The module can be installed automatically via download or manually by cloning.

## Automatic Install 
Open PowerShell and execute `(new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ElectronicWar/twitchstreamlister/master/Install.ps1") | iex`.
This will automatically download TwitchStreamLister as module into your profile. Restart PowerShell afterwards.

## Manual Install
Clone this repository and copy `TwitchListStreams.psm1` somewhere in `%UserProfile%\Documents\WindowsPowerShell\Modules\`. Or directly clone it into your `Modules` folder.

# Usage
Just type `Watch-TwitchStreams` and enjoy (be lazy and just type "Watch" and auto-complete with Tab).

# Modification
TwitchStreamLister is installed into `%UserProfile%\Documents\WindowsPowerShell\Modules\TwitchStreamLister\TwitchStreamLister.psm1`.

To change the listed game, edit the `Invoke-TwitchGetStreams` call at the end or remove the paramter completely for interative input. The used stream quality can be changed there as well, default is "best".

# Acknowlegments
Install script blatantly copied from the wonderful [PSget](http://psget.net/), go check it out!