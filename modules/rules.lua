-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Apps can't maximise themselves: the tiling decides their size.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- A fullscreen window takes focus on a click, not when the pointer moves over it. A window opened
-- over it (Super+Return's floating kitty) gets the focus, but the pointer is still on the fullscreen
-- window, and with follow_mouse = 1 (input.lua) the slightest nudge handed the keyboard back to it.
hl.window_rule({
    name  = "fullscreen-no-follow-mouse",
    match = { fullscreen = true },

    no_follow_mouse = true,
})

-- Shadows (look.lua) only where a window lies over something, as on macOS: floating windows, dialogs
-- and pinned ones. A tiled window has nothing under it but its neighbours, 4 px away, and a shadow
-- this wide would lie across them. These follow a window as it's toggled between the two.
hl.window_rule({
    name  = "no-shadow-tiled",
    match = { float = false },

    no_shadow = true,
})
hl.window_rule({
    name  = "no-shadow-fullscreen",
    match = { fullscreen = true },

    no_shadow = true,
})

-- Video stays solid: the 80 % glass (look.lua) washes the blurred wallpaper into the picture.
-- Fullscreen is already opaque; these cover video in a tiled or floating window.
hl.window_rule({
    -- Players that say they're showing video (mpv and others speaking wp-content-type)
    name  = "opaque-video-content",
    match = { content = "video" },

    opaque = true,
})
-- Solid whatever the content: VLC never says it's showing video, Firefox is solid whatever the tab
-- shows, and pictures too: the glass would tint every photo with the wallpaper behind it.
for _, name in ipairs({ "vlc", "firefox", "qimgv" }) do
    hl.window_rule({ name = "opaque-" .. name, match = { class = "^" .. name .. "$" }, opaque = true })
end
