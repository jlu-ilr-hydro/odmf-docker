# Database backup service

This small alpine based container runs a cronjob to
do an hourly, daily, weekly and monthly backup of the database.

It is also used to restore backups on a newly setup server

    $ docker-compose exec db_backup 'psql --dbname=$DB_URL'

or similar