-- Built and linked here by nixos-dotfiles' modules/features/hyprland/default.nix, which leaves a plugin
-- out while it doesn't match Hyprland's version: then there's nothing to load, and nothing of it below.
local dir = os.getenv("HOME") .. "/.local/lib/hyprland/plugins/"
local function load(name)
    local file = io.open(dir .. name .. ".so")
    if not file then return false end
    file:close()
    hl.plugin.load(dir .. name .. ".so")
    return true
end

-- Rotates the focused window, e.g. a sideways Firefox picture-in-picture video.
-- The arrow is where the window's top edge ends up pointing.
if load("hypr-window-rotate") then
    local mods = "SUPER + SHIFT + CTRL + ALT"
    hl.bind(mods .. " + up",    function() hl.plugin.window_rotate.rotate(0) end)
    hl.bind(mods .. " + right", function() hl.plugin.window_rotate.rotate(90) end)
    hl.bind(mods .. " + down",  function() hl.plugin.window_rotate.rotate(180) end)
    hl.bind(mods .. " + left",  function() hl.plugin.window_rotate.rotate(270) end)
end

-- Liquid glass on the windows and the island. Where it draws it replaces Hyprland's blur
-- (manage_blur), so look.lua's blur and `glass` layer rule are what's left when it's out or off.
-- The island's Settings writes its own presets on top (~/.config/island/hyprland.lua, loaded last by
-- hyprland.lua), so these are only the defaults without it.
if load("hyprglass") and hl.plugin.hyprglass then
    local hg = hl.plugin.hyprglass
    hg.config({
        default_preset = "pomme",
        layers = { enabled = true },
    })
    -- The island's overlay is full-screen: contour gives each shape it draws its own edge. The cut-off is
    -- look.lua's ignore_alpha, low, so an island set almost see-through keeps its glass (its shadow is
    -- a window of its own).
    hg.layer("glass:island", { mask_mode = "contour", mask_threshold = 0.01 })
end
