#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
JAVA_OPTS="{{ java_opts }}"
MINECRAFT_HOME="{{ minecraft_home }}"

tmux new-session -d -s "${TMUX_SESSION}" -n "${TMUX_WINDOW}" "/usr/bin/java ${JAVA_OPTS} -jar ${MINECRAFT_HOME}/server.jar nogui"
tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" "setworldspawn 0 0 0" ENTER