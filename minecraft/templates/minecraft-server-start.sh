#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
JAVA_OPTS="{{ java_opts }}"
MINECRAFT_HOME="{{ minecraft_home }}"

tmux new-session -d -s "${TMUX_SESSION}" -n "${TMUX_WINDOW}" "/usr/bin/java ${JAVA_OPTS} -jar ${MINECRAFT_HOME}/server.jar nogui"

# Check for '[Server thread/INFO]: Stopping server' in the latest.log to validate we are not looking at an old log file
while ! grep -q '\[Server thread\/INFO\]: Stopping server' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 5
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Waiting for server to reset log file..."
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking if the server has started..."
# look for this text '[Server thread/INFO]: Done ()! For help, type "help"' in the latest.log to validate the server has started 
while ! grep -q '\[Server thread\/INFO\]: Done' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Waiting for server to start..."
done 
echo "$(date '+%Y-%m-%d %H:%M:%S') - Server has started."