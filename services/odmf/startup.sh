#!/bin/bash

cat /db_url
# Create the ODMF server
odmf version
odmf -vv configure $DB_URL
odmf -vv db-create
TABLES=$(odmf db-tables)
odmf db-test

# Start the cron service
service rsyslog start
crontab /crontab
service cron start

# Start odmf
odmf start


