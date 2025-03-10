set fish_greeting

function fish_mode_prompt;
    switch $fish_bind_mode
    case default
      set_color --bold red
      echo '+'
    case insert
      set_color --bold cyan
      echo ' '
    case replace_one
      set_color --bold green
      echo 'R'
    case visual
      set_color --bold brmagenta
      echo 'V'
    case '*'
      set_color --bold red
      echo '?'
  end
  set_color normal
end

set fish_cursor_default block

if status is-interactive
  if not set -q TMUX
    if set -q TMUX_ATTACH
      if tmux has-session -t root > /dev/null 2>&1
        exec tmux attach-session -t "root"
      else
        exec tmux new-session -s "root"
      end
    else
      set session_name "session_$fish_pid"
      exec tmux new-session -s "$session_name" \; set-option destroy-unattached on
    end
  end
end

set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set __fish_git_prompt_use_informative_chars 'yes'
set -g fish_prompt_pwd_dir_length 3

# alias
alias vi 'nvim'
alias vim 'nvim'
alias mysql 'mariadb'
alias gcm 'git commit -m'
alias gcam 'git commit -am'
alias gps "git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)"
alias gd 'git diff'
alias gdc 'git diff --cached'
alias gds 'git diff --staged'
alias gp 'git push'
alias clip 'fish_clipboard_copy'

zoxide init fish | source

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$PATH"
