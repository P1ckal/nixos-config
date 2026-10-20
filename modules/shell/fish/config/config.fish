if status is-interactive
    # Commands to run in interactive sessions can go here
end
# =============================================================================

# Ensure runtime dir is set

if not set -q XDG_RUNTIME_DIR
    set -x XDG_RUNTIME_DIR /run/user/(id-u)
    if not test -d $XDG_RUNTIME_DIR
        mkdir -p $XDG_RUNTIME_DIR
        chmod 0700 $XDG_RUNTIME_DIR
    end
end

# Set session ID
if set -q TERM
    set tty_num (tty | grep -oP 'tty\K[0-9]+')
    if [ "$tty_num" != "" ]
        set -x XDG_SESSION_ID "tty$tty_num"
    end
end

zoxide init fish --cmd cd | source

starship init fish | source

direnv hook fish | source
