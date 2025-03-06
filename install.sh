#!/bin/bash

declare -A links=(
    [i3]="$HOME/.config/i3"
    [i3blocks]="$HOME/.config/i3blocks"
    [tmux]="$HOME/.config/tmux"
    [kitty]="$HOME/.config/kitty"
    [systemd]="$HOME/.config/systemd"
)

for name in "${!links[@]}"; do
    target="${links[$name]}"
    source="$HOME/dotfiles/$name"
    if [ ! -e "$target" ]; then
        ln -s "$source" "$target"
        echo "Created symlink for $name"
    else
        echo "Skipping $name $target already exists."
    fi
done
