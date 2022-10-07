#!/bin/bash

# Change umask to allow group access
umask 007

echo 'eval "$(_ODMF_COMPLETE=bash_source odmf)' >> ~/.bashrc
echo $DB_URL > /db_url
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


