-- Extra autostart processes.
--
-- Most of the sway autostart list is gone because Omarchy covers it: the shell
-- replaces waybar and dunst, themes set the wallpaper, dwindle replaces
-- autotiling, and the clipboard/keyring/portal/polkit bits are started by
-- default/hypr/autostart.lua. Only the genuinely personal ones are left.

-- Dictation HUD (see the window rule in hypr/windows.lua).
o.launch_on_start("dictate_desktop")

-- Discord (Flatpak); the focus-stealing rule lives in hypr/windows.lua.
o.launch_on_start("flatpak run com.discordapp.Discord")

-- Nextcloud sync client, straight to the tray.
o.launch_on_start("nextcloud --background")

-- Hold off the screensaver while audio plays. Browsers ask to stay awake over
-- D-Bus, which Omarchy's idle monitor doesn't hear; this speaks the Wayland
-- idle-inhibit protocol it does.
o.launch_on_start("wayland-pipewire-idle-inhibit")
