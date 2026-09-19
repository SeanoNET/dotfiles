-- Personal window rules.
--
-- Ported from the for_window / assign rules in the sway config. Omarchy's own
-- rules in default/hypr/windows.lua and default/hypr/apps/ load first; these
-- only add what was sway-specific.
--
-- Rule syntax: https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Modal TUIs launched with omarchy-launch-or-focus-tui --app-id=<id>.
--
-- Omarchy's own convention: anything tagged floating-window picks up its
-- float + center + 875x600 treatment from default/hypr/apps/system.lua. Tag
-- into it rather than re-declaring float/center, then override just the size.
-- Omarchy's rules load first, so these win.
o.window("^cheatsheet$", { tag = "+floating-window" })
o.window("^cheatsheet$", { size = { 1400, 900 } })

-- Dictate (XWayland) sits as a small always-centered HUD.
o.window("^dictate$", { float = true, center = true, size = { 240, 80 } })

-- Apps without a keybinding of their own still land on a fixed workspace.
o.window("thunderbird", { workspace = "3" })

-- Discord steals focus when a notification arrives; don't let it.
o.window("discord", { focus_on_activate = false })

-- Settings dialogs and about boxes are never worth tiling.
o.window("^(qt5ct|qt6ct|Blueberry\\.py|nm-connection-editor)$", { float = true, center = true })
o.window({ title = "^About " }, { float = true, center = true })
