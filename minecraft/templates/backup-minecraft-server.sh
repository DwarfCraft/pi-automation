#!/bin/bash

# Variables
SERVER_DIR="{{ minecraft_home }}"
BACKUP_DIR="{{ backup_dir }}"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/minecraft_backup_$TIMESTAMP.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup the important parts of the Minecraft server
tar -czvf $BACKUP_FILE $SERVER_DIR/world $SERVER_DIR/server.properties $SERVER_DIR/whitelist.json $SERVER_DIR/ops.json

# Only keep 7 days worth of backups
find $BACKUP_DIR -type f -name 'minecraft_backup_*' -mtime +7 -exec rm {} \;

# Print completion message
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed: $BACKUP_FILE"