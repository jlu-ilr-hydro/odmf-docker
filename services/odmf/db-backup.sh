#!/usr/bin/env bash
# Backup each table in the right order
# Use the period flag to do continuous backups

TODAY=$(/bin/date -I)
TAG=${TAG:-$TODAY}
TABLES=$(/usr/local/bin/odmf db-tables)
DIR="/var/backup/$TAG"
DB_URL=$(grep -Eo 'database_url:.*' /srv/odmf/config.yml | sed 's/database_url: //')
ODMF_NAME=$(basename $DB_URL)
mkdir -p $DIR
echo $DB_URL
for T in $TABLES
do
  FILE="$DIR/$T.$ODMF_NAME.sql.gz"
  /usr/bin/pg_dump --dbname=$DB_URL -at $T | gzip > $FILE
done


