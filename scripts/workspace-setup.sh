#!/bin/bash

# Start tmux sessions if they don't exist
tmux has-session -t dev 2>/dev/null || {
    tmux new-session -d -s dev -n editor
    tmux send-keys -t dev:editor "cd ~/Roche/repositories/dasense_be && nvim" C-m
    tmux new-window -t dev -n shell
    tmux send-keys -t dev:shell "cd ~/Roche/repositories/dasense_be" C-m
}

tmux has-session -t ops 2>/dev/null || {
    tmux new-session -d -s ops -n monitoring
    tmux send-keys -t ops:monitoring "btop" C-m
    tmux new-window -t ops -n logs
}

# Launch Ghostty with tmux attached to dev session
# (This assumes Ghostty is already configured)
open -a Ghostty --args -e tmux attach -t dev
