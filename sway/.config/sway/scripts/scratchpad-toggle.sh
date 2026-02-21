#!/bin/bash
if ! swaymsg '[app_id="scratchpad-term"] focus' 2>/dev/null | grep -q '"success":true'; then
    alacritty --class scratchpad-term &
    sleep 1.5
    swaymsg '[app_id="scratchpad-term"] floating enable, resize set 1000 600, move position center, move to scratchpad' 2>/dev/null
fi
swaymsg '[app_id="scratchpad-term"] scratchpad show' 2>/dev/null
sleep 0.2
swaymsg '[app_id="scratchpad-term"] move position center' 2>/dev/null
