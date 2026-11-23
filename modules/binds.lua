---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "yazi"
local menu        = "quickshell ipc call island open launcher"
local lock        = "quickshell ipc call lock screen"
local browser     = "firefox"
local fastfetch   = "fastfetch"
local session     = dofile(os.getenv("HOME") .. "/.config/hypr/session.lua")   -- awww, quickshell


---------------------
---- KEYBINDINGS ----
---------------------

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q",                hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q",        hl.dsp.window.close({ force = true }))
hl.bind(mainMod .. " + SHIFT + CTRL + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + SHIFT + SPACE",    hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + SPACE",     hl.dsp.window.pseudo())
hl.bind(mainMod .. " + ALT + SPACE",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",                hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + A",                hl.dsp.window.pin())
-- Works while locked too: if the lock screen died, this brings a new one.
hl.bind(mainMod .. " + Z",                hl.dsp.exec_cmd(lock), { locked = true })
hl.bind(mainMod .. " + R",                session.restart)

-- Quickshell island
hl.bind(mainMod .. " + A",                hl.dsp.exec_cmd("quickshell ipc call island togglePeek"))
hl.bind(mainMod .. " + SHIFT + A",        hl.dsp.exec_cmd("quickshell ipc call island toggleAutohide"))
hl.bind(mainMod .. " + ALT + A",          hl.dsp.exec_cmd("quickshell ipc call island open tabs"))
hl.bind(mainMod .. " + CTRL + A",         hl.dsp.exec_cmd("quickshell ipc call island open expanded"))

hl.bind(mainMod .. " + B",                hl.dsp.exec_cmd("quickshell ipc call island open bluetooth"))
hl.bind(mainMod .. " + Y",                hl.dsp.exec_cmd("quickshell ipc call island open network"))
hl.bind(mainMod .. " + N",                hl.dsp.exec_cmd("quickshell ipc call island open notifications"))
hl.bind(mainMod .. " + V",                hl.dsp.exec_cmd("quickshell ipc call island open mixer"))      -- every app's volume

-- Held as Alt+Tab is (Quickshell's Held.qml): the first press opens the view, the key again with
-- Super still down moves on (with Shift: back), letting go of Super picks the one reached.
hl.bind(mainMod .. " + TAB",              hl.dsp.exec_cmd("quickshell ipc call island cycle workspaces 1"))
hl.bind(mainMod .. " + SHIFT + TAB",      hl.dsp.exec_cmd("quickshell ipc call island cycle workspaces -1"))
hl.bind(mainMod .. " + P",                hl.dsp.exec_cmd("quickshell ipc call island cycle wallpapers 1"))
hl.bind(mainMod .. " + SHIFT + P",        hl.dsp.exec_cmd("quickshell ipc call island cycle wallpapers -1"))
hl.bind(mainMod .. " + SHIFT + V",        hl.dsp.exec_cmd("quickshell ipc call island cycle clipboard 1"))  -- the clipboard history
hl.bind(mainMod .. " + period",           hl.dsp.exec_cmd("quickshell ipc call island launch emoji"))      -- emoji, symbols, kaomoji
-- Super down and up, which those need: a global shortcut both ways, letting every other bind through.
for _, sym in ipairs({ "Super_L", "Super_R" }) do
    hl.bind(sym, hl.dsp.global("quickshell:island-super"),
        { ignore_mods = true, transparent = true, non_consuming = true, dont_inhibit = true, locked = true })
end
hl.bind(mainMod .. " + G",                hl.dsp.exec_cmd("quickshell ipc call island open dashboard"))
hl.bind(mainMod .. " + I",                hl.dsp.exec_cmd("quickshell ipc call island open settings"))
hl.bind(mainMod .. " + M",                hl.dsp.exec_cmd("quickshell ipc call island open media"))
hl.bind(mainMod .. " + U",                hl.dsp.exec_cmd("quickshell ipc call island open battery"))
hl.bind(mainMod .. " + T",                hl.dsp.exec_cmd("quickshell ipc call island open theme"))
hl.bind(mainMod .. " + C",                hl.dsp.exec_cmd("quickshell ipc call island open clock"))
hl.bind(mainMod .. " + X",                hl.dsp.exec_cmd("quickshell ipc call island open power"))

hl.bind(mainMod .. " + SPACE", function()
    local win = hl.get_active_window()
    if not win then return end -- nothing focused (e.g. empty workspace)
    hl.dispatch(hl.dsp.window.cycle_next({
        floating = not win.floating
    }))
end, { description = "Switch focus between tiled and floating windows" })

hl.bind(mainMod .. " + SHIFT + Return",   hl.dsp.exec_cmd(terminal .. " --hold -e " .. fastfetch))
-- A quick terminal: floating and centred at 1080x720, not tiled. The rules only touch this launch.
hl.bind(mainMod .. " + Return",           hl.dsp.exec_cmd(terminal, { float = true, size = "1080 720", center = true }))
-- The coding agent (crush, talking to the local Ollama), in the same kind of floating terminal
hl.bind(mainMod .. " + ALT + Return",     hl.dsp.exec_cmd(terminal .. " -e crush", { float = true, size = "1080 720", center = true }))
hl.bind(mainMod .. " + E",                hl.dsp.exec_cmd(terminal .. " -e " .. fileManager))
hl.bind(mainMod .. " + D",                hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W",                hl.dsp.exec_cmd(browser))

-- Screenshots
hl.bind("PRINT",                          hl.dsp.exec_cmd("grimblast --notify copy area"),   { locked = true })
hl.bind(mainMod .. " + PRINT",            hl.dsp.exec_cmd("grimblast --notify copy screen"), { locked = true })
hl.bind(mainMod .. " + SHIFT + PRINT",     hl.dsp.exec_cmd("mkdir -p ~/Pictures/Screenshots && grimblast --notify save area ~/Pictures/Screenshots/$(date +%s).png"), { locked = true })

-- Focus and move windows. move rather than swap: swap only trades places with a neighbour,
-- so it does nothing at a layout edge and can never restack windows.
local directions = {
    Left = "left", Right = "right", Up = "up", Down = "down",
    H    = "left", L     = "right", K  = "up", J    = "down",
}
for key, direction in pairs(directions) do
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ direction = direction }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

-- Switch/move workspaces with mainMod + [0-9]
for i = 1, 10 do
  local key = tostring(i % 10)  -- 10 → "0", 1-9 → "1"-"9"
  hl.bind(mainMod .. " +" .. key,         hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(mainMod .. " + SHIFT +" .. key,   hl.dsp.window.move({ workspace = tostring(i) }))
end

-- ─── Window Resize (hold to repeat) ──────────────────────────
hl.bind(mainMod .. " + ALT + Left",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + Right", hl.dsp.window.resize({ x = 30,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + Up",    hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + Down",  hl.dsp.window.resize({ x = 0, y = 30,  relative = true }), { repeating = true })

hl.bind(mainMod .. " + ALT + H",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + L",  hl.dsp.window.resize({ x = 30,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + K",  hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + J",  hl.dsp.window.resize({ x = 0, y = 30,  relative = true }), { repeating = true })

-- ─── Window Move / Float (hold to repeat) ─────────────────────
hl.bind(mainMod .. " + CTRL + Left",  hl.dsp.window.move({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.window.move({ x = 30,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + Up",    hl.dsp.window.move({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + Down",  hl.dsp.window.move({ x = 0, y = 30,  relative = true }), { repeating = true })

hl.bind(mainMod .. " + CTRL + H",  hl.dsp.window.move({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L",  hl.dsp.window.move({ x = 30,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K",  hl.dsp.window.move({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J",  hl.dsp.window.move({ x = 0, y = 30,  relative = true }), { repeating = true })

-- Example special workspace (scratchpad)
-- Escape is the Caps Lock key (caps:swapescape in input.lua)
hl.bind(mainMod .. " + Escape",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
