# The docker file for ODMF

# Using the official python:3.9 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./app/:/srv/odmf
#   - ./backup/:/var/backup

FROM python:3.10 AS base
MAINTAINER "Philipp Kraft"
LABEL version="2022.10.06"

RUN  apt-get update && apt-get install -y --no-install-recommends apt-utils && \
     apt-get install -y postgresql-client && \
     apt-get install -y cron rsyslog gzip bzip2 nano git

# Disable kernel logs in syslog
RUN sed 's/module(load="imklog")/#module(load="imklog")/' -i /etc/rsyslog.conf

ARG PIP=/usr/local/bin/pip3
ARG SOURCE=odmf

ENV ODMF_PORT=8081
ENV ODMF_DEFAULT_TIMEZONE=Europe/Berlin
ENV ODMF_ROOT_URL=/test
ENV ODMF_ADMIN_PW=test
ENV DB_URL=$DB_URL

RUN pip3 install --upgrade pip setuptools wheel

# Setup backup, mount /var/backup
COPY ./*.sh /
RUN chmod u+x /*.sh
COPY ./crontab /crontab
WORKDIR /srv/odmf

RUN pip3 install $SOURCE
ENV TARGET=prod
ENTRYPOINT ["/startup-prod.sh"]
