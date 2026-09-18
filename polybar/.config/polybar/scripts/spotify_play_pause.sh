#!/usr/bin/env bash
# Emit the appropriate play/pause glyph based on real Spotify state.
# Used by the spotify-play-pause polybar module (custom/script, tail = true).

playerctl --player=spotify status -F 2>/dev/null | while read -r status; do
    case "$status" in
        Playing) echo "󰏤" ;;
        *)       echo "" ;;
    esac
done
