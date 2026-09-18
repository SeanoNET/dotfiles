#!/bin/sh
# Wallpaper manager: random rotation or set a specific wallpaper
# Usage:
#   wallpaper.sh              — rotate random wallpapers every 30 minutes
#   wallpaper.sh --set <file> — set a specific wallpaper (stops rotation)

# Kill any existing wallpaper loop (prevents duplicates on sway reload)
for pid in $(pgrep -f "wallpaper\.sh" | grep -v $$); do
    kill "$pid" 2>/dev/null
done

WALLPAPER_DIR="$HOME/.config/backdrops"

# Set a specific wallpaper and exit (no rotation)
if [ "$1" = "--set" ] && [ -n "$2" ]; then
    if [ -f "$2" ]; then
        killall swaybg 2>/dev/null
        swaybg -i "$2" -m fill &
        echo "Wallpaper set to: $2"
    else
        echo "wallpaper.sh: file not found: $2" >&2
        exit 1
    fi
    exit 0
fi

if [ ! -d "$WALLPAPER_DIR" ] || [ -z "$(find -L "$WALLPAPER_DIR" -type f -print -quit 2>/dev/null)" ]; then
    echo "wallpaper.sh: no wallpapers in $WALLPAPER_DIR" >&2
    swaybg -c '#24283b' &
    exit 0
fi

while true; do
    WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f | shuf -n 1)
    killall swaybg 2>/dev/null
    swaybg -i "$WALLPAPER" -m fill &
    sleep 1800
done
