#!/bin/bash

# Toggle scratchpad terminal
# Check if window exists
if ! i3-msg '[class="scratchpad-term"] focus' 2>/dev/null | grep -q '"success":true'; then
    # Window doesn't exist, create it
    alacritty --class scratchpad-term &
    # Wait for window to appear
    sleep 1.5
    # Make sure it's configured properly
    i3-msg '[class="scratchpad-term"] floating enable, resize set 1000 600, move position center, move to scratchpad' 2>/dev/null
fi

# Toggle scratchpad (shows if hidden, hides if visible)
i3-msg '[class="scratchpad-term"] scratchpad show' 2>/dev/null

# Wait a moment for the window to appear
sleep 0.2

# Center the window if it's visible
i3-msg '[class="scratchpad-term"] move position center' 2>/dev/null

