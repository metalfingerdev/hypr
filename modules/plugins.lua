-- Built and linked here by nixos-dotfiles' modules/features/hyprland/default.nix, which leaves it out
-- while it doesn't match Hyprland's version: then there's nothing to load, and no rotate binds.
local plugin = os.getenv("HOME") .. "/.local/lib/hyprland/plugins/hypr-window-rotate.so"
local file = io.open(plugin)
if not file then return end
file:close()
hl.plugin.load(plugin)

-- Rotates the focused window, e.g. a sideways Firefox picture-in-picture video.
-- The arrow is where the window's top edge ends up pointing.
local mods = "SUPER + SHIFT + CTRL + ALT"
hl.bind(mods .. " + up",    function() hl.plugin.window_rotate.rotate(0) end)
hl.bind(mods .. " + right", function() hl.plugin.window_rotate.rotate(90) end)
hl.bind(mods .. " + down",  function() hl.plugin.window_rotate.rotate(180) end)
hl.bind(mods .. " + left",  function() hl.plugin.window_rotate.rotate(270) end)
