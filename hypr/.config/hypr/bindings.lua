-- Personal keybinding overrides.
--
-- These map Omarchy's defaults onto the sway muscle memory carried over from
-- the `wayland` branch (sway/.config/sway/config in this repo). Omarchy
-- defaults are left alone wherever they don't collide, so package updates can
-- still add new bindings.
--
-- Anything rebound below is unbound first, with a comment naming what Omarchy
-- had on that key and where it moved to.
--
-- See the resulting map with: omarchy menu keybindings --print

local terminal_class = "com.mitchellh.ghostty"

-- Launch on a dedicated workspace the first time, on the current workspace after.
local function launch_or_open(match, workspace, command)
  return string.format(
    "launch-or-open %s %s %s",
    o.shell_quote(match),
    o.shell_quote(workspace),
    command
  )
end

--------------------------------------------------------------------------------
-- Window management
--------------------------------------------------------------------------------

-- sway: $mod+q kills, $mod+w opens the browser. Omarchy closes on SUPER + W.
hl.unbind("SUPER + W") -- was: Close window (moved to SUPER + Q)
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- sway: $mod+Shift+space toggles floating.
hl.unbind("SUPER + SHIFT + SPACE") -- was: Toggle top bar (moved to SUPER + SHIFT + ALT + SPACE)
o.bind("SUPER + SHIFT + SPACE", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind_toggle("SUPER + SHIFT + ALT + SPACE", "Toggle top bar", "bar")

-- sway: $mod+t focuses the tablet (scrcpy). Omarchy floats on SUPER + T, which
-- is now on SUPER + SHIFT + SPACE above.
hl.unbind("SUPER + T") -- was: Toggle window floating/tiling (moved to SUPER + SHIFT + SPACE)
o.bind("SUPER + T", "Focus tablet (scrcpy)", "omarchy-launch-or-focus scrcpy scrcpy")

-- sway: $mod+backslash splits horizontally. Hyprland only has togglesplit, and
-- SUPER + J is needed for vim-style focus below.
hl.unbind("SUPER + J") -- was: Toggle window split (moved to SUPER + BACKSLASH)
o.bind("SUPER + BACKSLASH", "Toggle window split", hl.dsp.layout("togglesplit"))

--------------------------------------------------------------------------------
-- Vim-style focus and window movement (sway: $mod+hjkl / $mod+Shift+hjkl)
--
-- The arrow-key equivalents are already Omarchy defaults and stay as they are.
--------------------------------------------------------------------------------

hl.unbind("SUPER + K") -- was: Keybindings (moved to SUPER + F1, matching sway's $mod+F1)
hl.unbind("SUPER + L") -- was: Toggle workspace layout (moved to SUPER + ALT + L)

o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

o.bind("SUPER + F1", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

--------------------------------------------------------------------------------
-- Resize mode (sway: $mod+r enters a resize submap, Return/Escape leaves)
--------------------------------------------------------------------------------

hl.define_submap("resize", "reset", function()
  local step = 40

  local function grow(x, y)
    return hl.dsp.window.resize({ x = x, y = y, relative = true })
  end

  hl.bind("H", grow(-step, 0), { description = "Shrink width", repeating = true })
  hl.bind("L", grow(step, 0), { description = "Grow width", repeating = true })
  hl.bind("K", grow(0, -step), { description = "Shrink height", repeating = true })
  hl.bind("J", grow(0, step), { description = "Grow height", repeating = true })

  hl.bind("LEFT", grow(-step, 0), { description = "Shrink width", repeating = true })
  hl.bind("RIGHT", grow(step, 0), { description = "Grow width", repeating = true })
  hl.bind("UP", grow(0, -step), { description = "Shrink height", repeating = true })
  hl.bind("DOWN", grow(0, step), { description = "Grow height", repeating = true })

  hl.bind("RETURN", hl.dsp.submap("reset"), { description = "Leave resize mode" })
  hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Leave resize mode" })
end)

o.bind("SUPER + R", "Resize mode", hl.dsp.submap("resize"))

--------------------------------------------------------------------------------
-- Workspaces
--
-- sway: $mod+Tab is back-and-forth, $mod+Ctrl+Tab is next. Omarchy has those
-- two swapped. SUPER + SHIFT + TAB (previous) already matches.
--------------------------------------------------------------------------------

hl.unbind("SUPER + TAB") -- was: Next workspace (moved to SUPER + CTRL + TAB)
hl.unbind("SUPER + CTRL + TAB") -- was: Former workspace (moved to SUPER + TAB)
o.bind("SUPER + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))
o.bind("SUPER + CTRL + TAB", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))

-- sway: $mod+Shift+n jumps to the first empty workspace.
hl.unbind("SUPER + SHIFT + N") -- was: Editor (moved to SUPER + E)
o.bind("SUPER + SHIFT + N", "Open next empty workspace", "empty-workspace")

--------------------------------------------------------------------------------
-- Applications
--
-- launch-or-open puts the first instance on a dedicated workspace and opens
-- later instances on the current one, matching the sway setup.
--------------------------------------------------------------------------------

-- sway: $mod+Return opens ghostty running tmux on workspace 1.
hl.unbind("SUPER + RETURN") -- was: Terminal (this replaces it, pinned to workspace 1)
o.bind("SUPER + RETURN", "Terminal (tmux)", launch_or_open(terminal_class, "1",
  "xdg-terminal-exec -e bash -c 'tmux new-session -A'"))

-- sway: $mod+e opens Zed on workspace 1.
o.bind("SUPER + E", "Editor", launch_or_open("dev.zed.Zed", "1", "zeditor"))

-- sway: $mod+w opens the browser on workspace 2.
o.bind("SUPER + W", "Browser", launch_or_open("^zen", "2", "zen-browser"))

-- sway: $mod+n opens the file manager on workspace 3.
o.bind("SUPER + N", "File manager", launch_or_open("org.gnome.Nautilus", "3", "nautilus"))

-- sway: $mod+m opens the music TUI in a floating popup.
o.bind("SUPER + M", "Music TUI", "popup-tui --size 1400x800 spotify_player")

-- sway: $mod+d opens the launcher. Omarchy's apps menu is the equivalent, and
-- stays on SUPER + ALT + SPACE as well.
o.bind("SUPER + D", "Apps menu", "omarchy-menu toggle apps")

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------

-- sway: $mod+v opens the clipboard history, which Omarchy has on SUPER + CTRL + V.
-- Omarchy's universal paste is dropped rather than moved: it was never part of
-- the sway map, and CTRL+V / SHIFT+Insert still paste natively. SUPER + C and
-- SUPER + X (universal copy/cut) are left alone.
hl.unbind("SUPER + V") -- was: Universal paste (dropped)
o.bind("SUPER + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- sway: $mod+Shift+s grabs a region to the clipboard. Print (full screen) is
-- already an Omarchy default and is left alone.
hl.unbind("SUPER + SHIFT + S") -- was: Google Maps (unbound, use the apps menu)
o.bind("SUPER + SHIFT + S", "Screenshot region", "omarchy-capture-screenshot region copy")

-- sway: $mod+Shift+x locks the screen. Omarchy's SUPER + CTRL + L still works.
hl.unbind("SUPER + SHIFT + X") -- was: X (unbound, use the apps menu)
o.bind("SUPER + SHIFT + X", "Lock system", "omarchy-system-lock")

-- sway: $mod+Shift+p switches power profiles.
hl.unbind("SUPER + SHIFT + P") -- was: Google Photos (unbound, use the apps menu)
o.bind("SUPER + SHIFT + P", "Power", "omarchy-shell shell toggle omarchy.power")

-- sway: $mod+Shift+r reloads the compositor config.
o.bind("SUPER + SHIFT + R", "Reload Hyprland config", "hyprctl reload")
