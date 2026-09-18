#!/usr/bin/env bash

# Wait for any previous instances to actually exit before relaunching, otherwise
# the new bar can lose the tray selection race to a process that is still dying.
killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

if type "xrandr" >/dev/null 2>&1; then
  monitors=$(xrandr --query | grep " connected" | cut -d" " -f1)
  # Only one bar may own the system tray - polybar's internal/tray claims an X
  # selection, so running it on every monitor is a race. Pin it to the primary
  # output, falling back to the first connected one if no primary is set.
  tray_monitor=$(xrandr --query | awk '/ connected primary/ {print $1; exit}')
  [ -n "$tray_monitor" ] || tray_monitor=$(echo "$monitors" | head -1)

  for m in $monitors; do
    if [ "$m" = "$tray_monitor" ]; then
      bar=toph-tray
    else
      bar=toph
    fi
    MONITOR=$m polybar --reload "$bar" &
  done
else
  polybar --reload toph-tray &
fi

# No snixembed here on purpose. It bridges StatusNotifierItem icons to the
# XEmbed tray, but Proton VPN's item is malformed (ToolTip and IconPixmap typed
# "s" instead of "(sa(iiay)ss)" / "a(iiay)") and aborts it - taking every other
# proxied icon down with it. 1Password, Nextcloud, qBittorrent, Steam and
# Flameshot all dock natively as XEmbed, and Spotify already has its own
# modules, so the bridge bought nothing but a crash. See module/protonvpn.
