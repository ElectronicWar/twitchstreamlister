TwitchStreamLister
==================

This is a small PowerShell module to list the top 25 live streams on [Twitch.tv](http://www.twitch.tv) to a given game.
Afterwards you're able to launch a stream just using it's number using an installed [LiveStreamer](https://github.com/chrippa/livestreamer) instance. Perfect for your bedside notebook :D

![Console Output](https://raw.githubusercontent.com/ElectronicWar/twitchstreamlister/master/Screenshot.png)

## Requirements
This script requires at least PowerShell 4.0 (due to the usage of `Invoke-RestMethod`).
Make sure you sign the script or enable unrestricted script access. To do this, start PowerShell as Administrator and execute `Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Confirm`.

## Automatic Installation
Open PowerShell and execute `(new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ElectronicWar/twitchstreamlister/master/Install.ps1") | iex`.
This will automatically download TwitchStreamLister as module into your profile in a few seconds.

## Manual Installation
Clone this repository and copy `TwitchListStreams.psm1` somewhere in `%UserProfile%\Documents\WindowsPowerShell\Modules\`. Or directly clone it into your `Modules` folder.

## Usage
Just type `Watch-TwitchStreams` and enjoy (be lazy and just type "Watch" and auto-complete with Tab).

## How to change game and quality
TwitchStreamLister is installed into `%UserProfile%\Documents\WindowsPowerShell\Modules\TwitchStreamLister\TwitchStreamLister.psm1`.

To change the listed game, edit the `Invoke-TwitchGetStreams` call at the end or remove the paramter completely for interative input. The used stream quality can be changed there as well, default is "best".

Make sure to restart your PowerShell after changes since modules are only loaded once on start.

## Forks and modifications
If you make substantial changes or want to fork and develop your own version, please register your program with Twitch.tv to retrieve your own Client ID for use with [Twitch.tv API](https://github.com/justintv/twitch-api). To do this, go to [http://www.twitch.tv/settings/connections](http://www.twitch.tv/settings/connections) and click on "Register your application" at the botton. It's fast and free :)

## Acknowlegments
Automatic install script blatantly copied from the wonderful [PSget](http://psget.net/), go check it out!

## Thanks
Written with [Sublime Text](http://www.sublimetext.com) and Microsoft PowerShell ISE. Docs made with the free [MarkdownPad 2](http://www.markdownpad.com/). Source code management done with the great [SourceTree App](http://www.sourcetreeapp.com/). Project hosted by [GitHub](http://www.github.com). <3