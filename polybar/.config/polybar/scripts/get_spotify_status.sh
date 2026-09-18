#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="toph"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Set the source audio player here.
# Players supporting the MPRIS spec are supported.
# Examples: spotify, vlc, chrome, mpv and others.
# Use `playerctld` to always detect the latest player.
# See more here: https://github.com/altdesktop/playerctl/#selecting-players-to-control
PLAYER="playerctld"

# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
FORMAT="{{ title }} - {{ artist }}"

# Note: the play/pause icon is now driven by its own dedicated script
# (spotify_play_pause.sh) that follows playerctl status, so this script
# no longer needs to emit polybar-msg hooks.

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    if [ "$STATUS" = "Stopped" ]; then
        echo "No music is playing"
    elif [ "$STATUS" = "No player is running" ]; then
        echo "$STATUS"
    else
        playerctl --player=$PLAYER metadata --format "$FORMAT"
    fi
fi