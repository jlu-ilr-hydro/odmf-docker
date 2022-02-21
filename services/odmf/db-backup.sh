#!/usr/bin/env bash
# Backup each table in the right order
# Use the period flag to do continuous backups

TODAY=$(date -I)
TAG=${TAG:-$TODAY}
TABLES=$(odmf db-tables)

ODMF_NAME=$(basename $DB_URL)
DIR="/var/backup/$TAG"
mkdir -p $DIR

for T in $TABLES
do
  FILE="$DIR/$T.$ODMF_NAME.sql.$BACKUP_ZIP"
  echo "$FILE"
  pg_dump --dbname=$DB_URL -at $T | $BACKUP_ZIP > $FILE
done


