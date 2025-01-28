#!/bin/bash

TMUX_SESSION="{{ tmux_session }}"
TMUX_WINDOW="{{ tmux_window }}"
MINECRAFT_HOME="{{ minecraft_home }}"
MINECRAFT_USER="{{ minecraft_user }}"

# Validate the server has started before running the command.
# look for this text '[Server thread/INFO]: Done ()! For help, type "help"' in the latest.log to then run the command
while ! grep -q '\[Server thread\/INFO\]: Done' ${MINECRAFT_HOME}/logs/latest.log; do
    sleep 1
    echo "Waiting for server to start..."
done 
# run commands as minecraft user to set the world spawn point to 0 0 0
sudo -u $MINECRAFT_USER tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" "setworldspawn 0 0 0" 
sudo -u $MINECRAFT_USER tmux send -t "${TMUX_SESSION}:${TMUX_WINDOW}" ENTER   

# Print completion message
echo "Command completed: setworldspawn 0 0 0"

# setup cronjob to run the backup-minecraft-server.sh script every hour
echo "Setting up cronjob to run the backup-minecraft-server.sh script every hour"
# Variables
BACKUP_SCRIPT="{{ minecraft_home }}/backup-minecraft-server.sh"
CRONJOB_SCHEDULE="0 * * * * $MINECRAFT_USER $BACKUP_SCRIPT"

# Add the cron job to the crontab
(crontab -l -u $MINECRAFT_USER 2>/dev/null; echo "$CRONJOB_SCHEDULE") | crontab -u $MINECRAFT_USER -

# Print completion message
echo "Cronjob created: $CRONJOB_FILE"

