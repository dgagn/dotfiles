# no greeting
set fish_greeting
# dont fuck my cursor with no line stuff
set fish_cursor_default block
set fish_cursor_insert block
set fish_cursor_visual block

set fish_color_command 96cbfe

set -x LS_COLORS "di=38;2;150;203;254:$LS_COLORS"

set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set __fish_git_prompt_use_informative_chars 'yes'
set -g fish_prompt_pwd_dir_length 3

# https://wiki.archlinux.org/title/XDG_Base_Directory
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/var/cache"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_DATA_DIRS "/usr/local/share:/usr/share"
set -x XDG_CONFIG_DIRS "/etc/xdg"

set -x PYTHON_HISTORY "$HOME/var/history/python"
set -x NODE_REPL_HISTORY "$HOME/var/history/node"
set -x PSQL_HISTORY "$HOME/var/history/psql"
set -x MYSQL_HISTFILE "$HOME/var/history/mysql"
set -x REDISCLI_HISTFILE "$HOME/var/history/redis"
set -x GDBHISTFILE "$HOME/var/history/gdb"

set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# only true editor
set -x EDITOR "nvim"
set -x PATH "$CARGO_HOME/bin::$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$PATH"

set -x TEXMFHOME "$XDG_DATA_HOME/texmf"
set -x TEXMFVAR "$XDG_CACHE_HOME/texlive/texmf-var"
set -x TEXMFCONFIG "$XDG_CONFIG_HOME/texlive/texmf-config"

set -x TERMINAL "kitty"

set -x MANPAGER 'nvim +Man!'

source "$CARGO_HOME/env.fish"
