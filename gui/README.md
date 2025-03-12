# gui config

This directory contains configuration files for graphical components of my i3 setup.
I use x11 because wayland is not as stable.

## i3wm

i3 is my tiling window manager of choice because the keymaps and everything
out of the box feels so good. The best window manager that i've tried so far.

- Installation `sudo pacman -S i3-wm`
- [i3](https://wiki.archlinux.org/title/I3)

## i3blocks

i3blocks is required by my i3 config because i wanted to customize the default
status bar to include the sound (the only reason really lol).

- Installation `sudo pacman -S i3blocks`

## i3lock

This makes it so it grabs the logind locks to lock my session when I am away from
my computer.

- Installation `sudo pacman -S i3lock`
- [Session lock](https://wiki.archlinux.org/title/Session_lock)

## scrot

It's super lightweight for screenshotting and works very well out of the box. It's
minimalist and I like it.

- Installation `sudo pacman -S scrot`
- [Screen capture](https://wiki.archlinux.org/title/Screen_capture)

## feh

Lightweight image viewer that handles my desktop background and opening images
easily inside a viewer.

- Installation `sudo pacman -S feh`
- [Feh](https://wiki.archlinux.org/title/Feh)

## picom

My compositor of choice. It's only used so I can have 0.98 opacity on my terminal.
Not that useful, but whatev. I also made a systemd service so it can run reliably.

- Installation `sudo pacman -S picom`
- [Picom](https://wiki.archlinux.org/title/Picom)

## dmenu

A good default option for i3 to launch my applications. Tried rofi, but I prefer
dmenu because it's more minimalist and feels faster.

- Installation `sudo pacman -S dmenu` (already installed by i3)
- [Dmenu](https://wiki.archlinux.org/title/Dmenu)

## kitty

A good terminal. I used alacritty for a long time, but kitty has image rendering.
It's the only reason I use kitty over alacritty for now. It's a good editor, no
problem with it yet, except that it provides alot out of the box, which I don't
personnally like, but whatever. I disabled most of the features.

- Installation `sudo pacman -S kitty`
- [Kitty](https://wiki.archlinux.org/title/Kitty)

## firefox

One of the browser I use, but I don't really care between firefox and google-chrome.

- Installation `sudo pacman -S firefox`
- [Firefox](https://wiki.archlinux.org/title/Firefox)

## fontconfig

This manages system-wide fonts and my rendering settings.

- Installation `sudo pacman -S fontconfig`
- [Font configuration](https://wiki.archlinux.org/title/Font_configuration)

## discord

Pretty good communication application.

- Installation `sudo pacman -S discord`
- [Discord](https://wiki.archlinux.org/title/Discord)

## jetbrains mono nerd font

This font is the best I have ever used. I don't use any jetbrains products, but
this font feels so good ! I highly recommend to try it

- Installation `sudo pacman -S ttf-jetbrains-mono-nerd`
- [Fonts](https://wiki.archlinux.org/title/Fonts)
