#!/bin/bash
# Backup btrfs snapshots to Unraid Backups share via rsync
# Runs as a systemd timer — exits gracefully if share is unavailable

set -euo pipefail

BACKUP_BASE="/mnt/unraid/backups/snapshots/$(hostname)"
SNAPPER_CONFIGS=("root" "home")

# Check if backup share is accessible
if ! mountpoint -q /mnt/unraid/backups 2>/dev/null && ! ls /mnt/unraid/backups/ &>/dev/null; then
    echo "Backup share /mnt/unraid/backups not available, skipping"
    exit 0
fi

for config in "${SNAPPER_CONFIGS[@]}"; do
    if ! snapper -c "$config" list &>/dev/null; then
        echo "Snapper config '$config' not found, skipping"
        continue
    fi

    # Get the latest snapshot number
    LATEST=$(snapper -c "$config" list --columns number | tail -1 | tr -d ' ')
    if [[ -z "$LATEST" || "$LATEST" == "number" ]]; then
        echo "No snapshots found for '$config', skipping"
        continue
    fi

    # Determine snapshot path
    if [[ "$config" == "root" ]]; then
        SNAP_PATH="/.snapshots/${LATEST}/snapshot"
    else
        SUBVOL=$(snapper -c "$config" get-config | grep "^SUBVOLUME" | awk '{print $NF}')
        SNAP_PATH="${SUBVOL}/.snapshots/${LATEST}/snapshot"
    fi

    if [[ ! -d "$SNAP_PATH" ]]; then
        echo "Snapshot path $SNAP_PATH does not exist, skipping"
        continue
    fi

    DEST="${BACKUP_BASE}/${config}/latest"
    mkdir -p "$DEST"

    echo "Syncing $config snapshot #${LATEST} to ${DEST}..."
    rsync -a --delete --info=progress2 "$SNAP_PATH/" "$DEST/"
    echo "Done: $config snapshot #${LATEST}"

    # Write metadata
    echo "{\"config\": \"$config\", \"snapshot\": $LATEST, \"date\": \"$(date -Iseconds)\", \"hostname\": \"$(hostname)\"}" > "${DEST}/../backup-info.json"
done

echo "Snapshot backup complete"
