#!/bin/bash

# Variables
SERVER_DIR="{{ minecraft_home }}"
BACKUP_DIR="{{ backup_dir }}"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/minecraft_backup_$TIMESTAMP.tar.gz"
HASH_FILE="$BACKUP_DIR/backup_hashes.txt"
MAX_BACKUP_SIZE=20000000  # 20GB in KB
MAX_HASH_FILE_SIZE=1024  # 1MB in KB

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup the important parts of the Minecraft server using rsync for incremental backups
rsync -a --delete $SERVER_DIR/world $SERVER_DIR/config $SERVER_DIR/server.properties $SERVER_DIR/whitelist.json $SERVER_DIR/ops.json $BACKUP_DIR/incremental/

# Create a compressed archive of the incremental backup
tar -czf $BACKUP_FILE -C $BACKUP_DIR incremental

# Update hash file to avoid recalculating checksums
NEW_HASH=$(sha256sum $BACKUP_FILE | cut -d ' ' -f1)
if grep -q $NEW_HASH $HASH_FILE; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Duplicate backup detected, removing: $BACKUP_FILE"
    rm $BACKUP_FILE
else
    echo $NEW_HASH >> $HASH_FILE
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed: $BACKUP_FILE"
fi

# Ensure the hash file stays below 1MB
if [ $(du -k $HASH_FILE | cut -f1) -gt $MAX_HASH_FILE_SIZE ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Hash file exceeds 1MB, truncating..."
    tail -n 1000 $HASH_FILE > $HASH_FILE.tmp && mv $HASH_FILE.tmp $HASH_FILE
fi

# Only keep a max of 20GB of backups
while [ $(du -s $BACKUP_DIR | cut -f1) -gt $MAX_BACKUP_SIZE ]; do
    OLDEST_BACKUP=$(ls -t $BACKUP_DIR/minecraft_backup_* | tail -1)
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup directory is over 20GB, deleting oldest backup: $OLDEST_BACKUP"
    rm $OLDEST_BACKUP
done