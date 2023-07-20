# The docker file for ODMF

# Using the official python:3.10 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./app/:/srv/odmf

FROM python:3.10 AS base
MAINTAINER "Philipp Kraft"
LABEL version="2023.07.20"

RUN  apt-get update && apt-get install -y --no-install-recommends apt-utils && \
     apt-get install -y gzip nano git

# Disable kernel logs in syslog
# RUN sed 's/module(load="imklog")/#module(load="imklog")/' -i /etc/rsyslog.conf

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
WORKDIR /srv/odmf

RUN pip3 install $SOURCE
echo $'PS1=\'\[\033[01;32m\]\u@\[\033[01;36m\]odmf:/$ODMF_ROOT_URL\[\033[01;34m\]\w\[\033[00m\]\$ \'' >> ~/.bashrc
RUN echo 'eval "$(_ODMF_COMPLETE=bash_source odmf)"' >> ~/.bashrc
ENV TARGET=prod
ENTRYPOINT ["/startup-prod.sh"]
