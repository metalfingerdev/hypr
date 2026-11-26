-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- This machine's own screens (a laptop panel at a fixed mode...) come from ~/.config/hypr-host/monitors.lua,
-- written by its host in nixos-dotfiles: this folder is a read-only link, so that file can't live here.
local host = os.getenv("HOME") .. "/.config/hypr-host/monitors.lua"
local f = io.open(host)
if f then f:close(); pcall(dofile, host) end

-- Anything else plugged in: its own best mode, placed beside the others instead of on top of them.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
