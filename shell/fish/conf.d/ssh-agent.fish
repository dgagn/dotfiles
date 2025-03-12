set -Ux SSH_AUTH_SOCK "$HOME/.ssh/ssh-agent.sock"

if test -S "$SSH_AUTH_SOCK"
    if set -q SSH_AGENT_DEBUG
        echo "SSH agent already running."
    end
else
    if set -q SSH_AGENT_PID
        # ignore errors
        kill $SSH_AGENT_PID 2> /dev/null
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

# === ADD GPG AGENT SUPPORT ===

# Ensure GPG uses the correct TTY
export GPG_TTY=(tty)
set -Ux GPG_TTY (tty)

# Start GPG Agent if not running
if not pgrep -x gpg-agent > /dev/null
    gpgconf --launch gpg-agent
    echo "Started new GPG agent."
end

# Enable passphrase caching for GPG
set -Ux GPG_AGENT_SOCK (gpgconf --list-dirs agent-socket)
