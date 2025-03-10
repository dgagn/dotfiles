mkdir -p "$HOME/.ssh"

set -Ux SSH_AUTH_SOCK "$HOME/.ssh/ssh-agent.sock"

if test -S "$SSH_AUTH_SOCK"
    if set -q SSH_AGENT_DEBUG
        echo "SSH agent already running."
    end
else
    if set -q SSH_AGENT_PID
        kill $SSH_AGENT_PID
    end

    rm -f "$SSH_AUTH_SOCK"

    eval (ssh-agent -c | sed 's/^echo/#echo/' | sed -E 's/^setenv ([^ ]+) (.+)$/set -Ux \1 \2/')

    ln -sf (echo $SSH_AUTH_SOCK) "$HOME/.ssh/ssh-agent.sock"

    set -Ux SSH_AUTH_SOCK "$HOME/.ssh/ssh-agent.sock"
    echo "Started new SSH agent."
end

if test (ssh-add -l ^ /dev/null | string match -r "no identities")
    ssh-add ~/.ssh/id_rsa 2>/dev/null
end
