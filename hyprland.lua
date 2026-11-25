-- The config lives in modules/: autoload.lua runs every .lua file there, in name order.
--
--   autostart.lua  programs started with Hyprland
--   binds.lua      programs and keybindings
--   env.lua        environment variables, permissions
--   input.lua      keyboard, mouse, touchpad, gestures, devices
--   look.lua       gaps, borders, the glass (opacity, blur, `glass` layer rule), animations
--   monitors.lua   monitors
--   plugins.lua    plugins: window rotation (and its binds), liquid glass (hyprglass)
--   rules.lua      window and workspace rules
--
-- session.lua (here, not in modules/) lists the programs that come with the session: autostart.lua
-- starts them, and Super+R restarts them along with the config.

require("autoload")

-- The island's glass and window settings, written by its Settings (quickshell's Glass.qml). Last, so they win
-- over look.lua and plugins.lua; hyprglass only takes presets while the config loads, so the island writes
-- this file and reloads. A broken or missing file leaves the config as it is.
local island = os.getenv("HOME") .. "/.config/island/hyprland.lua"
local f = io.open(island)
if f then f:close(); pcall(dofile, island) end
