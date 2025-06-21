#!/bin/bash

PY_SCRIPT="$HOME/.config/polybar/scripts/i3layout.py"

# Check for pip
if ! command -v pip &>/dev/null; then
    echo "Error: pip not found. Install it with:"
    echo "  sudo pacman -S python-pip"
    exit 1
fi

# Install i3ipc if needed
if ! python3 -c "import i3ipc" &>/dev/null; then
    echo "Installing i3ipc..."
    pip install --user i3ipc || { echo "Failed to install i3ipc"; exit 1; }
fi

# Run the Python script using python3
python3 "$PY_SCRIPT"
