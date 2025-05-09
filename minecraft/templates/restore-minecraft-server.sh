#!/bin/bash

# Variables
SERVER_DIR="{{ minecraft_home }}"
BACKUP_DIR="{{ backup_dir }}"

# Find the latest backup file
echo "Looking for latest backup in $BACKUP_DIR..."
LATEST_BACKUP=$(ls -t $BACKUP_DIR/minecraft_backup_*.tar.gz 2>/dev/null | head -1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup file found in $BACKUP_DIR."
    exit 1
fi

echo "Restoring backup from $LATEST_BACKUP to $SERVER_DIR..."

# Stop the Minecraft server before restoring (uncomment if needed)
# systemctl stop minecraft-server

# Extract the backup to a temporary directory
TMP_RESTORE="$BACKUP_DIR/restore_tmp_$$"
mkdir -p "$TMP_RESTORE"
tar -xzf "$LATEST_BACKUP" -C "$TMP_RESTORE"

# Rsync extracted files to the server directory
rsync -a --delete "$TMP_RESTORE/incremental/" "$SERVER_DIR/"

# Clean up temporary directory
rm -rf "$TMP_RESTORE"

# Start the Minecraft server after restoring (uncomment if needed)
# systemctl start minecraft-server

echo "Restore completed."
