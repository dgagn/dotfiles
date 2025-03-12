# gui config

This directory contains configuration files for the graphical components of my i3 setup.
I use X11 because Wayland is not as stable.

## i3wm

i3 is my tiling window manager of choice because the key mappings and overall
experience feel great out of the box. It is the best window manager I have ever
tried.

- Installation `sudo pacman -S i3-wm`
- [i3](https://wiki.archlinux.org/title/I3)

## i3blocks

i3blocks is required for my i3 configuration because I wanted to customize the
default status bar to include sound controls (which is really the only reason, lol).

- Installation `sudo pacman -S i3blocks`

## i3lock

This ensures that my session is locked when I am away from my computer by grabbing
the logind locks.

- Installation `sudo pacman -S i3lock`
- [Session lock](https://wiki.archlinux.org/title/Session_lock)

## scrot

A super lightweight screenshot tool that works very well out of the box. It's
minimalist, and I like it.

- Installation `sudo pacman -S scrot`
- [Screen capture](https://wiki.archlinux.org/title/Screen_capture)

## feh

A lightweight image viewer that handles my desktop background and allows me to
open images easily.

- Installation `sudo pacman -S feh`
- [Feh](https://wiki.archlinux.org/title/Feh)

## picom

My compositor of choice. I use it only to set the terminal opacity to 0.98. Not
that useful, but whatever. I also created a systemd service to ensure it runs
reliably.

- Installation `sudo pacman -S picom`
- [Picom](https://wiki.archlinux.org/title/Picom)

## dmenu

A good default application launcher for i3. I tried Rofi but prefer dmenu because
it's more minimalist and feels faster.

- Installation `sudo pacman -S dmenu` (already installed by i3)
- [Dmenu](https://wiki.archlinux.org/title/Dmenu)

## kitty

A solid terminal. I used Alacritty for a long time, but Kitty supports image rendering,
which is the only reason I switched. It’s a good terminal with no major issues,
though it includes a lot of features out of the box, which I personally don't like.
I have disabled most of them.

- Installation `sudo pacman -S kitty`
- [Kitty](https://wiki.archlinux.org/title/Kitty)

## firefox

One of the browsers I use. I don’t have a strong preference between Firefox and
Google Chrome.

- Installation `sudo pacman -S firefox`
- [Firefox](https://wiki.archlinux.org/title/Firefox)

## fontconfig

Manages system-wide fonts and rendering settings.

- Installation `sudo pacman -S fontconfig`
- [Font configuration](https://wiki.archlinux.org/title/Font_configuration)

## discord

A solid communication application.

- Installation `sudo pacman -S discord`
- [Discord](https://wiki.archlinux.org/title/Discord)

## jetbrains mono nerd font

The best font I have ever used. I don’t use JetBrains products, but this font
feels amazing! Highly recommended.

- Installation `sudo pacman -S ttf-jetbrains-mono-nerd`
- [Fonts](https://wiki.archlinux.org/title/Fonts)
