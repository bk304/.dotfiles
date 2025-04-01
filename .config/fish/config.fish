if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $PATH:/home/bruno/.cargo/bin
set SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

eval (ssh-agent -c)
ssh-add ~/.ssh/k304_rsa
