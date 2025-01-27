#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
MINECRAFT_HOME="{{ minecraft_home }}"

Validate the server has started before running the command.
# look for this text '[Server thread/INFO]: Done ()! For help, type "help"' in the latest.log to then run the command
while ! grep -q '\[Server thread\/INFO\]: Done' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 1
    echo "Waiting for server to start..."
done 
tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" "setworldspawn 0 0 0" 
tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" ENTER   