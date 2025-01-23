#!/bin/bash

# Set default values if environment variables do not exist
TMUX_SESSION="${TMUX_SESSION:-minecraft}"
TMUX_WINDOW="${TMUX_WINDOW:-fabric}"
JVM_OPTS="${JVM_OPTS:--server -XX:+UseConcMarkSweepGC -XX:MaxGCPauseMillis=50 -Xmx3G}"
minecraft_home="${minecraft_home:-/opt/minecraft}"

tmux new-session -d -s "${TMUX_SESSION}" -n "${TMUX_WINDOW}" "/usr/bin/java ${JVM_OPTS} -jar ${minecraft_home}/server.jar nogui"