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
