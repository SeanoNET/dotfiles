-- Personal keybindings.
--
-- Omarchy's defaults are kept as-is. Everything below sits on a key Omarchy
-- leaves free, so nothing here unbinds or replaces a default, and package
-- updates can keep adding bindings without colliding.
--
-- See the resulting map with: omarchy menu keybindings --print

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

-- Second close key alongside Omarchy's SUPER + W.
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

--------------------------------------------------------------------------------
-- Resize mode (SUPER + R enters, Return/Escape leaves)
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
-- Applications
--
-- launch-or-open puts the first instance on a dedicated workspace and opens
-- later instances on the current one.
--------------------------------------------------------------------------------

o.bind("SUPER + E", "Editor (Zed)", launch_or_open("dev.zed.Zed", "1", "zeditor"))
o.bind("SUPER + N", "File manager", launch_or_open("org.gnome.Nautilus", "3", "nautilus"))

-- Same as Omarchy's SUPER + ALT + SPACE.
o.bind("SUPER + D", "Apps menu", "omarchy-menu toggle apps")

--------------------------------------------------------------------------------
-- Utilities
--------------------------------------------------------------------------------

-- Launched as a modal TUI: omarchy-launch-or-focus-tui reuses the window if
-- it's already open, and the app-id picks up the floating-window rules in
-- hypr/windows.lua.
o.bind("SUPER + F2", "Cheatsheet", "omarchy-launch-or-focus-tui --app-id=cheatsheet glow -p " ..
  o.shell_quote(os.getenv("HOME") .. "/dotfiles/CHEATSHEET.md"))

o.bind("SUPER + SHIFT + R", "Reload Hyprland config", "hyprctl reload")
