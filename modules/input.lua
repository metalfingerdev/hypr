hl.config({
    input = {
        kb_layout  = "us",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- This machine's keyboard (another layout, Caps as Escape...) from ~/.config/hypr-host/input.lua, written
-- by the host in nixos-dotfiles; hl.config merges key by key, so it only needs what differs.
local host = os.getenv("HOME") .. "/.config/hypr-host/input.lua"
local f = io.open(host)
if f then f:close(); pcall(dofile, host) end

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
