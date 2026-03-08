#!/bin/bash
# Launch an app on a target workspace if no instance exists,
# otherwise launch a new instance on the current workspace.
#
# Usage: launch-or-open.sh <app_id> <workspace> <command...>

app_id="$1"
workspace="$2"
shift 2

# Check for existing window (native Wayland app_id or XWayland class)
if swaymsg -t get_tree | jq -e --arg id "$app_id" \
    '.. | objects | select(.app_id == $id or .window_properties.class == $id)' \
    >/dev/null 2>&1; then
    exec "$@"
fi

# No existing window — launch and move to target workspace
"$@" &

for _ in $(seq 1 50); do
    sleep 0.2
    if swaymsg -t get_tree | jq -e --arg id "$app_id" \
        '.. | objects | select(.app_id == $id or .window_properties.class == $id)' \
        >/dev/null 2>&1; then
        swaymsg "[app_id=\"$app_id\"] move container to workspace number $workspace"
        swaymsg "workspace number $workspace"
        break
    fi
done
