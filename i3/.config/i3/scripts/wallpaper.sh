#!/bin/sh
#Make sure to stow the backgrounds in ~/.config/backdrops first

WALLPAPER_DIR="$HOME/.config/backdrops"

while true; do
    feh --bg-fill --randomize "$WALLPAPER_DIR"
    sleep 1800  # 30 minutes in seconds
done