function b --description "Run a command in a detached tmux window"
    if test (count $argv) -eq 0
        echo "usage: b <command>"
        return 1
    end

    set -l name $argv[1]
    set -l cmd (string join ' ' (string escape -- $argv))

    tmux new-window -d -c (pwd) -n "$name" "$cmd"
end
