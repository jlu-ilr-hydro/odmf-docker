TODAY=$(/bin/date -I)
TAG=${1:-$TODAY}
TABLES=$(</var/backup/tables)
DIR="/var/backup/$TAG"
DB_URL="postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB"
mkdir -p $DIR
for T in $TABLES
do
    FILE="$DIR/$T.$POSTGRES_DB.sql.gz"
    echo "$T.$POSTGRES_DB -> $FILE"
    /usr/bin/pg_dump --dbname=$DB_URL -at $T | gzip > $FILE
done
