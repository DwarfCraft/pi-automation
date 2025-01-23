#!/bin/bash

# Set default values if environment variables do not exist
TMUX_SESSION="${TMUX_SESSION:-minecraft}"
TMUX_WINDOW="${TMUX_WINDOW:-fabric}"

tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" "stop" ENTER

loop=60
while [ $loop -gt 0 ]; do
    # Loop again unless the tmux window is closed
    tmux list-windows -F '#{window_name}' -t "${TMUX_SESSION}" 2>&1 | grep -q "^${TMUX_WINDOW}$"
    if [ $? = 0 ] ; then
        loop=$((loop - 1))
        sleep 1
        continue
    fi
    break
done