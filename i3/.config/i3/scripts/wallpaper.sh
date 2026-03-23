#!/bin/sh
#Make sure to stow the backgrounds in ~/.config/backdrops first

WALLPAPER_DIR="$HOME/.config/backdrops"

while true; do
    feh --bg-scale --randomize "$WALLPAPER_DIR"
    sleep 300  # 5 minutes in seconds
done