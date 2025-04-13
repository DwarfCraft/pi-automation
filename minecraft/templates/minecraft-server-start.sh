#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
JAVA_OPTS="{{ java_opts }}"
MINECRAFT_HOME="{{ minecraft_home }}"
JAVA_OPTS_FILE="${MINECRAFT_HOME}/java_opts.txt"

echo "${JAVA_OPTS}" > ${JAVA_OPTS_FILE}

tmux new-session -d -s "${TMUX_SESSION}" -n "${TMUX_WINDOW}" "/usr/bin/java @${JAVA_OPTS_FILE} -jar ${MINECRAFT_HOME}/server.jar nogui"

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