#!/bin/bash
pushd "$(dirname ${BASH_SOURCE:0})"
trap popd EXIT
cp /srv/odmf/template/services/pg-backup/db-backup.sh ./backup_pg
# Use echo to strip whitespace
[ ! -f ./backup_pg/tables ] && echo $(docker-compose exec web odmf db-tables) | dos2unix >> ./backup_pg/tables
docker-compose exec db bash /var/backup/db-backup.sh $1
