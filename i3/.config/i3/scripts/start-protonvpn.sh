#!/usr/bin/env bash
#
# Start Proton VPN with a visible window.
#
# This used to wait for snixembed's org.kde.StatusNotifierWatcher and then start
# with --start-minimized. That cannot work here. The app only draws a tray icon
# when a watcher exists, and when one does exist it publishes a
# StatusNotifierItem with ToolTip and IconPixmap typed "s" instead of the spec's
# "(sa(iiay)ss)" and "a(iiay)", which aborts snixembed on the spot. So there is
# never a tray icon to minimise into, and --start-minimized just made the window
# vanish on login.
#
# polybar's module/protonvpn stands in for the icon: it shows connection state
# and opens this window on click.
exec protonvpn-app
