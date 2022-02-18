#!/usr/bin/env bash
TABLES=$(odmf tables)
ODMF_NAME=$(basename $DB_URL)
for T in $TABLES
do
  echo "$T.$(basename $DB_URL).$(date -I)"
  pg_dump --dbname=$DB_URL -at $T | gzip > $T.$ODMF_NAME.$(date -I).sql.gz
done


