# dotfiles

**personal dotfiles for my arch linux i3 neovim config**

## Installation

First, **clone this repo** into your home directory:

```sh
git clone --depth=1 https://github.com/ovior/dotfiles.git "$HOME/dotfiles"
```

Then, install the configurations you want with **GNU stow**

```sh
stow -vt "$XDG_CONFIG_HOME" editor
stow -vt "$XDG_CONFIG_HOME" shell
stow -vt "$XDG_CONFIG_HOME" gui
stow -vt "$XDG_DATA_HOME" share
```

Make sure your xdg paths are set before or set them manually where you want.

## Tools

| Tool | Installation |
| --- | --- |
| GNU stow | `sudo pacman -S stow` |
| git | `sudo pacman -S git` |
| tmux | `sudo pacman -S tmux` |
| fish | `sudo pacman -S fish` |
| neovim | `sudo pacman -S neovim` |
| --- | --- |
| i3 | `sudo pacman -S i3-wm` |
| i3blocks | `sudo pacman -S i3blocks` |
| i3lock | `sudo pacman -S i3lock` |
| kitty | `sudo pacman -S kitty` |
| fontconfig | `sudo pacman -S fontconfig` |
| dunst | `sudo pacman -S dunst` |
| picom | `sudo pacman -S picom` |
| rofi | `sudo pacman -S rofi` |

## PGP information

You can view pgp information [here](./pgp/README.md)

*tldr*

```sh
gpg --keyserver hkps://keys.openpgp.org --recv-keys C2C26F41BC1D5608
```

## todo

- Add a way to add dependencies
- Add templating options for some config files like global font, passwords and
so on
