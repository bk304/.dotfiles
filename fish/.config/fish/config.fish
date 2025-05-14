if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

set PATH $PATH:/home/bruno/.cargo/bin
set SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

eval (ssh-agent -c) > /dev/null
ssh-add ~/.ssh/k304_rsa > /dev/null 2>&1

