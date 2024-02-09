#!/bin/bash

# Change umask to allow group access
umask 007
# Create the ODMF server
odmf version
odmf -vv configure $DB_URL
odmf -vvv db-create
TABLES=$(odmf db-tables)
odmf db-test
# Start odmf
odmf start


