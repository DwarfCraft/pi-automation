#!/bin/bash

# Variables
SERVER_DIR="/opt/minecraft"
BACKUP_DIR="/opt/backup"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/minecraft_backup_$TIMESTAMP.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup the important parts of the Minecraft server
tar -czvf $BACKUP_FILE $SERVER_DIR/world $SERVER_DIR/server.properties $SERVER_DIR/whitelist.json $SERVER_DIR/ops.json

# Print completion message
echo "Backup completed: $BACKUP_FILE"