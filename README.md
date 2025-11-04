# dotfiles

**personal dotfiles for my arch linux i3 neovim config**

## Installation

First, **clone this repo** into your home directory

```sh
git clone --depth=1 https://github.com/ovior/dotfiles.git "$HOME/dotfiles"
```

Then, install the configurations you want with [stow](https://www.gnu.org/software/stow/)

```sh
stow -vt "$XDG_CONFIG_HOME" editor
stow -vt "$XDG_CONFIG_HOME" shell
stow -vt "$XDG_CONFIG_HOME" gui
stow -vt "$XDG_DATA_HOME" share
```

Ensure your [XDG base directory](https://wiki.archlinux.org/title/XDG_Base_Directory) are 
correctly set before running these commands, or manually specify where you want 
the configurations to be applied.

## Tools

Each tool has its own **README.md** inside its respective directory.

- [Gui Configurations](./gui/README.md)

*tldr these are the tools explained*

### Gui

The graphical components of my i3wm setup with [Xorg](https://wiki.archlinux.org/title/Xorg).

| Tool | Installation |
| --- | --- |
| i3wm (window manager) | `sudo pacman -S i3-wm` |
| i3blocks (status bar) | `sudo pacman -S i3blocks` |
| i3lock (session lock) | `sudo pacman -S i3lock` |
| scrot (screenshot tool) | `sudo pacman -S scrot` |
| feh (wallpaper and image viewer) | `sudo pacman -S scrot` |
| picom (compositor) | `sudo pacman -S picom` |
| dmenu (application launcher) | `sudo pacman -S dmenu` |
| dunst (notifications) | `sudo pacman -S dunst` |
| kitty (terminal) | `sudo pacman -S kitty` |
| fontconfig (font management) | `sudo pacman -S fontconfig` |
| jetbrains mono font (font) | `sudo pacman -S ttf-jetbrains-mono-nerd` |

### Shell

| Tool | Installation |
| --- | --- |
| stow | `sudo pacman -S stow` |
| git | `sudo pacman -S git` |
| fish | `sudo pacman -S fish` |
| tmux | `sudo pacman -S tmux` |

### Editor

The only *real* editor.

| Tool | Installation |
| --- | --- |
| neovim | `sudo pacman -S neovim` |


## PGP information

You can view pgp information [here](./pgp/README.md)

*tldr*

```sh
gpg --keyserver hkps://keys.openpgp.org --recv-keys C2C26F41BC1D5608
```

## todo

- Add a way to add dependencies
- Add templating options for some config files like global font, passwords and
so on.
