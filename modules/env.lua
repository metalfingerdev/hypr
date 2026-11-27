-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "macOS")
hl.env("HYPRCURSOR_THEME", "macOS")
-- Qt apps started from Hyprland read qt6ct (home-manager's qt.nix writes its config: Kvantum, the teal palette)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
