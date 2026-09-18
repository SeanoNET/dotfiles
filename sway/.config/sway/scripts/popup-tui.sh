#!/bin/bash
# Launch a TUI app in a centered floating popup terminal.
# If a popup with the same app_id already exists, focus it instead.
# Usage: popup-tui.sh [--size WxH] <command> [args...]
# Requires for_window rules in sway config for app_id="com.popup.*"

SIZE="900 600"
if [[ "$1" == "--size" ]]; then
    SIZE="${2/x/ }"
    shift 2
fi

APP_NAME="$(basename "$1")"
APP_ID="com.popup.${APP_NAME}"

# Focus existing window if one is already open
EXISTING=$(swaymsg -t get_tree | jq -r ".. | select(.app_id? == \"$APP_ID\") | .id" 2>/dev/null | head -1)

if [[ -n "$EXISTING" ]]; then
    swaymsg "[app_id=\"$APP_ID\"] focus"
else
    setsid ghostty --class="$APP_ID" --gtk-single-instance=false -e "$@" &>/dev/null &
    sleep 0.5
    swaymsg "[app_id=\"$APP_ID\"] resize set $SIZE, move position center"
fi
