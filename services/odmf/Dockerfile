# The docker file for ODMF

# Using the official python:3.10 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./app/:/srv/odmf

FROM python:3.10 AS base
MAINTAINER "Philipp Kraft"
LABEL version="2024.1.1dev"

RUN  apt-get update && apt-get install -y --no-install-recommends apt-utils && \
     apt-get install -y gzip nano git

# Disable kernel logs in syslog
# RUN sed 's/module(load="imklog")/#module(load="imklog")/' -i /etc/rsyslog.conf
ENV PIP_ROOT_USER_ACTION=ignore
ARG PIP_ROOT_USER_ACTION=ignore
ARG PIP=/usr/local/bin/pip3
ARG SOURCE=https://github.com/jlu-ilr-hydro/odmf/archive/refs/heads/master.zip
RUN mkdir -p /var/source/
COPY src/ /var/source/
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

RUN --mount=type=cache,target=/root/.cache pip3 install $SOURCE --upgrade
RUN echo 'eval "$(_ODMF_COMPLETE=bash_source odmf)"' >> ~/.bashrc
ENV TARGET=prod
ENTRYPOINT ["/startup-prod.sh"]
