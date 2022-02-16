# odmf-docker

This is a dockerized setup for the [Observatory Data Management Framework - ODMF](https://github.com/jlu-ilr-hydro/odmf)

Edit the .env file to change the environment settings, especially better passwords are a good idea!

## .env Variables

### Selecting the odmf version

Github repository to donwload odmf from:

    SOURCE_REPO_URL=jlu-ilr-hydro/odmf

Github branch to use:

    SOURCE_BRANCH=master

### Settings for the server

Port for the internal server port. The included docker-compose.yml exposes that port to the host

    ODMF_PORT=8081
Default timezone

    ODMF_DATETIME_DEFAULT_TIMEZONE=Europe/Berlin
Base url

    ODMF_ROOT_URL=/test
Admin password. Pro Tip: Change to something randomly generated
    ODMF_ADMIN_PW=test

### Database settings

Type of the database to use (tested with postgres and sqlite)

    DB_TYPE=postgres

Username, password and database name. Does not really matter as the database is hidden inside the docker framework anyway  

    DB_USER=db_user
    DB_PASSWORD=db_pw
    DB_NAME=odmf

## Usage:

Start database and a cherrpy server. The server is not configured for SSL, so use a reverse proxy!
    
    $ docker-compose up -d

On first start, the following directories are created:

 - instance: all configuration and extra data for ODMF are saved here. The start.py program is used for startup
 - data_backup: This folder includes 

The database is stored in a docker volume