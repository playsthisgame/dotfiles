# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a Stow package mirroring the layout expected under `$HOME`. Symlinking a package into `~` is done with:

```sh
stow <package>
```

For example, `stow nvim` creates `~/.config/nvim` pointing at `dotfiles/nvim/.config/nvim`.

## Packages

| Package | Config |
|---------|--------|
| `aerospace` | AeroSpace window manager |
| `ghostty` | Ghostty terminal |
| `nvim` | Neovim |
| `starship` | Starship prompt |
| `tmux` | tmux |
| `yazi` | Yazi file manager |

## Usage

```sh
# Install a single package
stow nvim

# Install all packages
stow */

# Remove a package (unlink)
stow -D nvim
```
