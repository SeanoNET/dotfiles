#!/bin/bash
# this script randomly shifts the polybar position by 0–2px every 5 minutes to prevent burn-in on OLED screens
CONFIG="$HOME/.config/polybar/config" # adjust if needed
BAR_NAME="toph"

while true; do
  X=$((RANDOM % 3)) # shift 0–2px horizontally
  Y=$((RANDOM % 3)) # shift 0–2px vertically

  # Update config (assumes offset-x/y are in the [bar/toph] section)
  sed -i "/^\[bar\/$BAR_NAME\]/,/^\[/{s/^offset-x = .*/offset-x = ${X}px/}" "$CONFIG"
  sed -i "/^\[bar\/$BAR_NAME\]/,/^\[/{s/^offset-y = .*/offset-y = ${Y}px/}" "$CONFIG"

  # Restart all running bars named 'toph'
  pkill -x polybar
  if type "xrandr" > /dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload "$BAR_NAME" &
    done
  else
    polybar --reload "$BAR_NAME" &
  fi

  sleep 3 # every 5 minutes
done