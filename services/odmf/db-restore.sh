#!/bin/bash
# Restores the database from a backup made with /db-backup.sh
set -e
PREFIX=$1
PREFIX=${PREFIX:-.}
TABLES=$(odmf db-tables)
RTABLES=$(tac -s' '<<<$TABLES)
echo "$PREFIX/[TABLE].[ODMF_NAME].sql.gz"
for T in $RTABLES
do
   echo "$T"
   psql -d $DB_URL -c "DELETE FROM $T;"
done
for T in $TABLES
do
  echo "$PREFIX/$T.*.sql.gz*"
  gunzip -c $PREFIX/$T.*.sql.gz* | psql -d $DB_URL
done