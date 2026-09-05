-- Personal window rules.
--
-- Ported from the for_window / assign rules in the sway config. Omarchy's own
-- rules in default/hypr/windows.lua and default/hypr/apps/ load first; these
-- only add what was sway-specific.
--
-- Rule syntax: https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Floating popup terminals opened by the popup-tui script. The script may
-- override the size with --size, but everything else comes from here.
o.window("^com\\.popup\\..*$", { float = true, center = true, size = { 900, 600 } })

-- Dictate (XWayland) sits as a small always-centered HUD.
o.window("^dictate$", { float = true, center = true, size = { 240, 80 } })

-- Apps without a keybinding of their own still land on a fixed workspace.
o.window("thunderbird", { workspace = "3" })

-- Discord steals focus when a notification arrives; don't let it.
o.window("discord", { focus_on_activate = false })

-- Settings dialogs and about boxes are never worth tiling.
o.window("^(qt5ct|qt6ct|Blueberry\\.py|nm-connection-editor)$", { float = true, center = true })
o.window({ title = "^About " }, { float = true, center = true })
