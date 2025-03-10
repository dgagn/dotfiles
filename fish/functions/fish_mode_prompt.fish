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
