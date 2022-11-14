# The ODMF postgres database service

This Dockerfile describes the db service of odmf. It is a thin layer
over the official postgres image including `db-edit`, `db-backup` and 
`db-restore` scripts

Backup and restore are only working if a file `/var/backup/tables` 
is available to get the names of tables needed.

Backup is called from outside the container, eg. the host's cron with

    docker-compose exec db db-backup TAG

Where TAG is a backup-label, eg. daily or weekly. If no TAG is given, db-backup
uses the iso-date as TAG

## Environment

    ENV POSTGRES_USER=db_user
    ENV POSTGRES_PASSWORD=db_passw
    ENV POSTGRES_DB=odmf
