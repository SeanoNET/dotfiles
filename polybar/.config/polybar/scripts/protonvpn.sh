#!/bin/sh
#
# Proton VPN status for polybar, standing in for the tray icon it cannot draw.
#
# The GTK app only publishes a StatusNotifierItem, which polybar's XEmbed tray
# does not speak. The usual bridge (snixembed) aborts on Proton's item because
# the app types ToolTip and IconPixmap as "s" instead of the "(sa(iiay)ss)" and
# "a(iiay)" the SNI spec requires, so it cannot be bridged either.
#
# proton0 is VIRTUAL_DEVICE_NAME for every protocol the app supports (wireguard,
# openvpn, protun), so its presence is the connection state.
if ip link show proton0 >/dev/null 2>&1; then
  echo "%{F#1b9fc6}vpn%{F-} on"
else
  echo "%{F#5a5a5a}vpn off%{F-}"
fi
