#!/bin/sh
# Kill any existing wallpaper loop (prevents duplicates on sway reload)
for pid in $(pgrep -f "wallpaper\.sh" | grep -v $$); do
    kill "$pid" 2>/dev/null
done

WALLPAPER_DIR="$HOME/.config/backdrops"

while true; do
    WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f | shuf -n 1)
    killall swaybg 2>/dev/null
    swaybg -i "$WALLPAPER" -m fill &
    sleep 1800
done
