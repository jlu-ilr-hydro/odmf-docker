# odmf-docker

This is a dockerized setup for the [Observatory Data Management Framework - ODMF](https://github.com/jlu-ilr-hydro/odmf)

The system is running as two services, `web` and `db`. 

- `web`: contains the webservice, written in Python on basis of the [odmf](https://github.com/jlu-ilr-hydro/odmf) package, carrying nearly a 1 GB of dependencies. The image is described in [services/odmf](services/odmf) and is based on the official [Python image](https://hub.docker.com/_/python)
- `db`: is based on an official [postgres image](https://hub.docker.com/_/postgres), with some helper scripts for backup and restore. The image is defined [services/odmf-db](services/odmf-db)

## Build from source

Get this repository

    git clone https://github.com/jlu-ilr-hydro/odmf-docker .

Build the images using `build.sh`

    bash build.sh

This script builds the images with today's date as image tag, copies the template for configuration to
`.env`, and alters the `docker-compose.yml` file to use the TODAY-tags of the 
two images.

## Configure basic settings

Edit the `.env`-file to set the environmental variables for your configuration.

### Settings for the server

- `ODMF_NAME` : Name of the ODMF instance
- `ODMF_PORT` : Port for the internal server port. The included docker-compose.yml exposes that port to the host
- `ODMF_DEFAULT_TIMEZONE=Europe/Berlin` : Default timezone
- `ODMF_ROOT_URL=/test` : Base url
- `ODMF_ADMIN_PW=test` : Admin password. Pro Tip: Change to something randomly generated

### Database settings

- `DB_TYPE=postgresql` : Type of the database to use (tested with postgresql and sqlite)
- `DB_USER=db_user` 
- `DB_PASSWORD=db_pw`
- `DB_NAME=odmf`

Username, password and database name. Does not really matter as the database is hidden inside the docker framework anyway

## First start

Now is a good time to do a first start of the system

    docker-compose up

And check the output.
You should have 1 Person and 5 Quality objects in the database and 0 other objects. (After the INFO lines) 

Watch for error messages, however `cherrypy.error ... ENGINE` messages are fine. In the end you should read some thing like:

    web_1  | INFO    : 2022-10-28 13:31:59 cherrypy.error [28/Oct/2022:13:31:59] ENGINE Bus STARTED

**Do not open** the web site at localhost:ODMF_PORT yet, but stop the service with Ctrl + C.

## Configuration of the Web-Service

Own the folders created by the first service start:

    sudo chown YOU -R app backup_pg

More configuration should be done by editing the file `app/config.yml`, especially important is to
set a `google_maps_api_key` and the `map_default` properties.

Now it is time to start up your services as daemons, so they are running in the background and restart
with your operating system. 

    docker-compose up -d

Show logs of the services:

    docker-compose logs

If everything is running, visit your new webservice using http. Protect you service from outside. For production usage we recommend to
place your service behind a reverse proxy with TLS encryption.

## Database backup and restore

### Perperation 
In order to perform database backup and restoration, the relevant table names need to be written in the right order of their dependencies into the backup volume:

    docker-compose exec web odmf db-tables | dos2unix >backup_pg/tables

The dos2unix is necessary as odmf db-tables currently produces a Windows line end, which we need to delete.

### Backup

A backup is performed with

    docker-compose exec db db-backup TAG

Where the TAG is some tag for your backup. If you do not write one, the current date is used. The TAG is used as a folder, backups with the same TAG overwrite each other.

Periodical backup is performed by the host's system, an example for crontab of the host is in the file `odmf-backup`. To use it, edit and save it (on most Linux) 
to `/etc/cron.d/`. It uses the `backup.sh` script, which checks for the presence of the `tables` file and creates it otherwise.  


### Restore

To restore data from another instance, copy the TAG folder containing the *.sql.gz files for restoring 
into the backup volume and run:

    docker-compose exec db db-restore TAG

The script does delete each record of your table and repopulates the table with the data from the backup. It does not replace the table structure! Hence, you can perform this restore on databases with a new fields.


