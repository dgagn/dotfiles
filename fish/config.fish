# no greeting
set fish_greeting
# dont fuck my cursor with no line stuff
set fish_cursor_default block

set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set __fish_git_prompt_use_informative_chars 'yes'
set -g fish_prompt_pwd_dir_length 3

# only true editor
export EDITOR="nvim"
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$PATH"
