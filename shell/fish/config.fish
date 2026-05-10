# no greeting
set fish_greeting
# dont fuck my cursor with no line stuff
set -g fish_cursor_default block
set -g fish_cursor_insert block
set -g fish_cursor_visual block

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

# set -x DATABASE_URL "mariadb://localhost/test"

# only true editor
set -x EDITOR "nvim"
set -x PATH "$CARGO_HOME/bin:$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$HOME/.config/composer/vendor/bin:/opt/ida:/opt/android-studio/bin:$HOME/var/share:$HOME/ida-home-pc-9.2:$PATH"

set -x TEXMFHOME "$XDG_DATA_HOME/texmf"
set -x TEXMFVAR "$XDG_CACHE_HOME/texlive/texmf-var"
set -x TEXMFCONFIG "$XDG_CONFIG_HOME/texlive/texmf-config"

set -x TERMINAL "kitty"

set -x MANPAGER 'nvim +Man!'

set -x TEXINPUTS "$HOME/texmf/latex/tex/tailwind/:$TEXINPUTS"

set -U fish_color_autosuggestion brblack
set -U fish_color_cancel --reverse
set -U fish_color_command 96cbfe
set -U fish_color_comment red
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end green
set -U fish_color_error brred
set -U fish_color_escape brcyan
set -U fish_color_history_current --bold
set -U fish_color_host normal
set -U fish_color_keyword
set -U fish_color_normal normal
set -U fish_color_operator brcyan
set -U fish_color_option
set -U fish_color_param normal
set -U fish_color_quote f6c177
set -U fish_color_redirection cyan --bold
set -U fish_color_search_match white --background=brblack
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path --underline

set -U fish_key_bindings fish_vi_key_bindings

set -U fish_pager_color_completion normal
set -U fish_pager_color_description yellow --italics
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_pager_color_selected_background --reverse

if test -d "$HOME/Android/Sdk"
    set -gx ANDROID_SDK_ROOT $HOME/Android/Sdk
    set -gx ANDROID_HOME $ANDROID_SDK_ROOT
    set -gx PATH $ANDROID_SDK_ROOT/platform-tools $ANDROID_SDK_ROOT/emulator $ANDROID_SDK_ROOT/cmdline-tools/latest/bin $PATH
end

if test -d "$HOME/.config/.android/avd"
    set -gx ANDROID_AVD_HOME $HOME/.config/.android/avd
end

source "$CARGO_HOME/env.fish"
direnv hook fish | source
