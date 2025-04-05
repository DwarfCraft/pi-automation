#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
MINECRAFT_HOME="{{ minecraft_home }}"
MINECRAFT_USER="{{ minecraft_user }}"
SERVER_COMMANDS=(
    "setworldspawn -177 63 -514"
    "worldborder set 6000"
    "gamerule doFireTick false"
    "gamerule playersSleepingPercentage 0"
)

echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking if the server has started..."
# Look for '[Server thread/INFO]: Stopping the server' and '[Server thread/INFO]: Done' in the latest.log to validate the server has started
while grep -q '\[Server thread\/INFO\]: Done' ${MINECRAFT_HOME}/logs/latest.log && grep -q '\[Server thread\/INFO\]: Stopping the server' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Server is shutting down, waiting..."
done
# Validate the server has started before running the command.
# look for this text '[Server thread/INFO]: Done ()! For help, type "help"' in the latest.log to then run the command
while ! grep -q '\[Server thread\/INFO\]: Done' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 5
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Waiting for server to start..."
done 
echo "$(date '+%Y-%m-%d %H:%M:%S') - Server has started."
# run commands as minecraft user to set the world spawn point to 0 0 0

# Loop through the SERVER_COMMANDS array and run the commands
for command in "${SERVER_COMMANDS[@]}"; do
    sudo -u $MINECRAFT_USER tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" "$command"
    sudo -u $MINECRAFT_USER tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" ENTER
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Command completed: $command"
done

# echo "2000 70 659 == Nether Forest
