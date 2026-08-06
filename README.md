# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a Stow package mirroring the layout expected under `$HOME`. Symlinking a package into `~` is done with:

```sh
stow <package>
```

For example, `stow nvim` creates `~/.config/nvim` pointing at `dotfiles/nvim/.config/nvim`.

## Packages

| Package | Platform | Config |
|---------|----------|--------|
| `aerospace` | macOS | AeroSpace window manager |
| `ghostty` | Any | Ghostty terminal |
| `herdr` | Any | herdr terminal workspace manager (see [note](#herdr-plugins)) |
| `hypr` | Linux (Wayland) | Hyprland compositor, hyprlock, and power script |
| `nvim` | Any | Neovim |
| `rofi` | Linux (Wayland) | Rofi application launcher |
| `starship` | Any | Starship prompt |
| `tmux` | Any | tmux |
| `vim` | Any | Vim |
| `vscode` | Any | VS Code settings/keybindings — shared source (see [note](#vs-code)) |
| `vscode-arch` | Linux | VS Code Stow package for Linux (`~/.config/Code/User`) |
| `vscode-mac` | macOS | VS Code Stow package for macOS (`~/Library/Application Support/Code/User`) |
| `waybar` | Linux (Wayland) | Waybar status bar |
| `wlogout` | Linux (Wayland) | wlogout logout menu |
| `yazi` | Any | Yazi file manager |

## Usage

```sh
# Install a single package
stow nvim

# Install all packages
stow */

# Remove a package (unlink)
stow -D nvim
```

## VS Code

`vscode/` holds the actual `settings.json` and `keybindings.json` and is the
single source of truth. The OS-specific packages don't duplicate them — the
files under `vscode-arch/` and `vscode-mac/` are symlinks back into `vscode/`,
mirroring the correct `$HOME` layout for each platform:

- `vscode-arch` → `~/.config/Code/User/`
- `vscode-mac` → `~/Library/Application Support/Code/User/`

Stow the package matching your OS (`stow vscode-mac` or `stow vscode-arch`);
edit the shared files in `vscode/` and both platforms pick up the change.

## herdr plugins

herdr keeps its plugin registry in `~/.config/herdr/plugins.json`, which it
regenerates per machine with **absolute** paths. Since `$HOME` differs between
machines, that file is gitignored and each machine registers plugins itself.

Vendored plugin sources are tracked under `herdr/.config/herdr/plugins/local/`.
After `stow herdr` on a new machine, register them once:

```sh
herdr plugin link ~/.config/herdr/plugins/local/vim-herdr-navigation
herdr server reload-config
```

Verify — the plugin should list with no warning and expose its actions:

```sh
herdr plugin list
herdr plugin action list --plugin vim-herdr-navigation
```

If `herdr plugin list` reports `manifest unavailable`, the registry is pointing
at a path from another machine; re-run the `link` command above.

`vim-herdr-navigation` also has an editor half, already wired up in the `nvim`
package (`nvim/.config/nvim/lua/config/keymaps.lua`), and needs `jq` on `PATH`
for its Vim-detection.
