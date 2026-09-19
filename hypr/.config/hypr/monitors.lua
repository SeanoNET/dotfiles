-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
-- Alienware AW3425DW ultrawide (native 3440x1440 @ 240Hz)
hl.monitor({ output = "DP-1", mode = "3440x1440@239.98", position = "0x0", scale = 1 })
-- Dell U2722DE, to the right of the ultrawide
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@59.95", position = "3440x0", scale = 1 })
