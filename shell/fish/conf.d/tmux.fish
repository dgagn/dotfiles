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

