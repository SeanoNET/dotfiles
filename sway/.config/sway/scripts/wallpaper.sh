#!/bin/sh
WALLPAPER_DIR="$HOME/.config/backdrops"

# Kill existing swaybg
killall swaybg 2>/dev/null

while true; do
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    killall swaybg 2>/dev/null
    swaybg -i "$WALLPAPER" -m fill &
    sleep 1800
done
