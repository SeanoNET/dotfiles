-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Load Omarchy defaults.
--
-- Kept on: the bindings below only override the handful of keys that collide
-- with the sway map carried over from the `wayland` branch, so new Omarchy
-- defaults keep arriving with package updates.
require("default.hypr.omarchy")

-- Personal overrides. Loaded after Omarchy's defaults so package updates can
-- improve the defaults without rewriting these files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.windows")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")
