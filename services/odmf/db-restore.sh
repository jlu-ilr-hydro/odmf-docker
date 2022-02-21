#!/bin/sh
# Restores the database from a backup made with db_backup.sh
TABLES=$(odmf tables)
ODMF_NAME=$(basename $DB_URL)
for T in $TABLES
do
  psql -d $DB_URL -c "DELETE FROM $T"
  gunzip -c $T.$ODMF_NAME.*.sql.gz | psql -d $DB_URL
done