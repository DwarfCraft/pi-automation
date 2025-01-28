#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
MINECRAFT_HOME="{{ minecraft_home }}"
MINECRAFT_USER="{{ minecraft_user }}"

# Check for '[Server thread/INFO]: Stopping server' in the latest.log to validate we are not looking at an old log file
while ! grep -q '\[Server thread\/INFO\]: Stopping server' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 5
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Waiting for server to reset log file..."
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking if the server has started..."
# Validate the server has started before running the command.
# look for this text '[Server thread/INFO]: Done ()! For help, type "help"' in the latest.log to then run the command
while ! grep -q '\[Server thread\/INFO\]: Done' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Waiting for server to start..."
done 
echo "$(date '+%Y-%m-%d %H:%M:%S') - Server has started."
# run commands as minecraft user to set the world spawn point to 0 0 0
sudo -u $MINECRAFT_USER tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" "setworldspawn 0 0 0" 
sudo -u $MINECRAFT_USER tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" ENTER   

# Print completion message
echo "$(date '+%Y-%m-%d %H:%M:%S') - Command completed: setworldspawn 0 0 0"
