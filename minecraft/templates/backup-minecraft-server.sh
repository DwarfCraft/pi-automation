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

# loop through all backups and only keep a single instance if they have the same sha256sum
for file in $(ls $BACKUP_DIR/minecraft_backup_*); do
    if [ $(sha256sum $file | cut -d ' ' -f1) == $(sha256sum $BACKUP_FILE | cut -d ' ' -f1) ]; then
        rm $BACKUP_FILE
        break
    fi
done

# Only keep a max of 20GB of backups
while [ $(du -s $BACKUP_DIR | cut -f1) -gt 20000 ]; do
    rm $(ls -t $BACKUP_DIR/minecraft_backup_* | tail -1)
done

# Print completion message
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed: $BACKUP_FILE"