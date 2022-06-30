## Symlink Dotfiles

This repository is organized for use with [GNU Stow](https://www.gnu.org/software/stow/).

Example:

```bash
# ~/dotfiles
stow alacritty
stow bash
stow config
stow git
stow gnupg
stow i3
# NOTE: This doesn't work for now -- it needs to be manually copied.
# See: https://github.com/kopia/kopia/issues/2037
# stow kopia
stow nvim
stow redshift
stow X
```

This automatically creates `$HOME` symlinks which mirror the directory structure. It works especially well for bins that have files and/or configuration located at one or more of `~`, `XDG_CONFIG_HOME`, or `XDG_DATA_HOME`.

See [this blog post](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) for a more in-depth explanation.

## Install Packages

**NOTE:** The following instructions assume you're using an Arch-based system.

Install community packages with Pacman:

(`--needed` makes it idempotent, skipping packages we already have that haven't changed versions)

```bash
sudo pacman -S --needed $(grep -v '^#' packages-community)
```


Install AUR packages with [paru](https://github.com/Morganamilo/paru):

(`--noprovides` skips the menu that displays alternatives, like binaries vs compilation from source)

```bash
sudo paru -S --needed --noprovides $(grep -v '^#' packages-aur)
```
