# The docker file for ODMF

# Using the official python:3.9 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./app/:/srv/odmf
#   - ./backup/:/var/backup

FROM python:3.9
MAINTAINER "Philipp Kraft"
LABEL version="2022.02.21"


RUN  apt-get update && \
     apt-get install -y postgresql-client && \
     apt-get install -y cron rsyslog gzip bzip2

ENV SOURCE_REPO_URL=jlu-ilr-hydro/odmf
ENV SOURCE_BRANCH=develop

RUN pip install --upgrade pip setuptools develop
# Fastest way to install from github
RUN pip install https://github.com/$SOURCE_REPO_URL/archive/$SOURCE_BRANCH.zip


ENV ODMF_PORT=8081
ENV ODMF_DATETIME_DEFAULT_TIMEZONE=Europe/Berlin
ENV ODMF_ROOT_URL=/test
ENV ODMF_ADMIN_PW=test

ENV DB_TYPE=postgres
ENV DB_USER=db_odmf_user
ENV DB_PASSWORD=db_password
ENV DB_NAME=odmf

# Get start script
RUN wget https://github.com/${SOURCE_REPO_URL}/raw/${SOURCE_BRANCH}/bin/start.py -O /srv/start-odmf.py

# Setup backup, mount /var/backup
ADD ./*.sh /
ADD ./crontab /crontab

RUN cron && crontab /crontab

WORKDIR /srv/odmf




