#!/bin/bash

export DB_URL=$DB_TYPE://$DB_USER:$DB_PASSWORD@$DB_HOST/$DB_NAME

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


