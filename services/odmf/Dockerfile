# The docker file for ODMF

# Using the official python:3.9 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./app/:/srv/odmf
#   - ./backup/:/var/backup

FROM python:3.9
MAINTAINER "Philipp Kraft"
LABEL version="2022.02.23"

RUN  apt-get update && \
     apt-get install -y postgresql-client && \
     apt-get install -y cron rsyslog gzip bzip2 nano

# Disable kernel logs in syslog
RUN sed 's/module(load="imklog")/#module(load="imklog")/' -i /etc/rsyslog.conf

ARG SOURCE_VERSION
ARG SOURCE_REPO_URL
ARG SOURCE_BRANCH
ARG SOURCE_ZIP_URL=https://github.com/$SOURCE_REPO_URL/archive/$SOURCE_BRANCH.zip

ARG PIP=/usr/local/bin/pip

RUN $PIP install --upgrade pip setuptools wheel
# Fastest way to install from github
RUN $PIP install $SOURCE_ZIP_URL

ENV ODMF_PORT=8081
ENV ODMF_DEFAULT_TIMEZONE=Europe/Berlin
ENV ODMF_ROOT_URL=/test
ENV ODMF_ADMIN_PW=test

ENV DB_URL=$DB_URL

# Setup backup, mount /var/backup
COPY ./*.sh /
RUN chmod u+x /*.sh
COPY ./crontab /crontab
RUN echo "$DB_URL" > /db_url
WORKDIR /srv/odmf
ENTRYPOINT ["/startup.sh"]
