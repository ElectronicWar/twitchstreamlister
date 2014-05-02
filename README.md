TwitchStreamLister
==================

This is a small PowerShell script to list the top 25 live streams on Twitch to a given game.
Afterwards you're able to launch a stream just using it's number using an installed [LiveStreamer](https://github.com/chrippa/livestreamer) instance.

To change the listed game, edit the `Invoke-TwitchGetStreams` call at the end or remove the paramter completely for interative input. The used stream quality can be changed in `Invoke-TwitchWatchStream` only in-code at the moment.