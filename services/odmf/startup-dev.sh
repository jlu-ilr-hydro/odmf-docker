#!/bin/bash

# Change umask to allow group access
umask 007
echo "**************************************************"
echo "DEVELOP"
echo "**************************************************"

if [ ! -d "/srv/odmf/src" ]; then
  git clone https://github.com/$SOURCE_REPO_URL /srv/odmf/src/
fi
cd src
git checkout $SOURCE_BRANCH
git pull
cd ..
$PIP install -r src/requirements.txt
$PIP install -e src/

cat /db_url
# Create the ODMF server
odmf version
odmf -vv configure $DB_URL
odmf -vv db-create
TABLES=$(odmf db-tables)
odmf db-test

echo "Start ODMF server with: odmf start"


