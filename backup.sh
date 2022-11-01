#!/bin/bash
pushd "$(dirname ${BASH_SOURCE:0})"
trap popd EXIT

# Create a list of tables to backup
# Use dos2unix to strip whitespace
[ ! -f ./backup_pg/tables ] && echo $(docker-compose exec web odmf db-tables) | dos2unix >> ./backup_pg/tables
docker-compose exec db db-backup $1
