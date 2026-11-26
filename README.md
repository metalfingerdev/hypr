# hypr

Hyprland config in Lua. `hyprland.lua` loads `autoload.lua`, which runs every file in `modules/` in name order (binds, input, look, monitors, rules, plugins...). `session.lua` lists the programs that start with the session.

Normally deployed as a flake input (`flake = false`) by
[nixos-dotfiles](https://github.com/metalfingerdev/nixos-dotfiles), which links it read-only to
`~/.config/hypr` ([docs/dotfiles.md](https://github.com/metalfingerdev/nixos-dotfiles/blob/main/docs/dotfiles.md)).

It is the same on every machine: per-machine monitors and keyboard go in the optional
`~/.config/hypr-host/{monitors,input}.lua` (without them: preferred mode, US layout). The island
(quickshell repo) writes `~/.config/island/hyprland.lua`, loaded last. Needs a Hyprland with Lua config
support, and the plugins from `modules/plugins.lua` if you keep them.

## Without NixOS

Clone it into the XDG config dir, or clone elsewhere and symlink it (or copy the files):

```sh
git clone https://github.com/metalfingerdev/hypr.git "${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
# or: ln -s ~/src/hypr "${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
```
