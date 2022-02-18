#!/bin/ash

# Change this to some magic with $0 getting the directory for the script
TODAY=$(date -I)
PERIOD=${PERIOD:-$TODAY}
FILE=/var/backup/$PERIOD.sql.$BACKUP_ZIP
pg_dump -a --dbname=$DB_URL | $BACKUP_ZIP >$FILE
echo $(date '+%Y-%m-%d %H:%M') $FILE >>/var/backup/backup.log
