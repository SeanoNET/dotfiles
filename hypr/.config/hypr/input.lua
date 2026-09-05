-- Personal input overrides. These replace the matching Omarchy defaults from
-- default/hypr/input.lua; everything not set here keeps Omarchy's value.

hl.config({
  input = {
    -- sway had `xkb_options caps:escape`. Omarchy's default puts Compose on
    -- Caps Lock instead, which breaks the vim habit of Caps as Escape.
    kb_options = "caps:escape",
  },
})
