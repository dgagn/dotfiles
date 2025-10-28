set -l sock "$XDG_RUNTIME_DIR/ssh-agent.sock"
if test -z "$XDG_RUNTIME_DIR"
    mkdir -p ~/.ssh
    set sock "$HOME/.ssh/agent.sock"
end

if not test -S "$sock"
    if set -q SSH_AGENT_PID
        kill $SSH_AGENT_PID ^ /dev/null
    end
    eval (ssh-agent -c -a "$sock" | sed -E 's/^setenv ([^ ]+) (.+)$/set -gx \1 \2/')
else
    set -gx SSH_AUTH_SOCK "$sock"
end

if ssh-add -l ^ /dev/null | string match -rq "no identities"
    if test -f ~/.ssh/id_rsa
        ssh-add ~/.ssh/id_rsa ^ /dev/null
    end
end

set -gx GPG_TTY (tty)
if not pgrep -x gpg-agent > /dev/null
    gpgconf --launch gpg-agent
end
set -gx GPG_AGENT_SOCK (gpgconf --list-dirs agent-socket)
