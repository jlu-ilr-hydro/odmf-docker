# The docker file for ODMF's database

# Using the official python:3.9 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./backup/:/var/backup

FROM postgres:14
MAINTAINER "Philipp Kraft"
LABEL version="2022.10.21"

RUN  apt-get update && apt-get install -y --no-install-recommends apt-utils && \
     apt-get install -y nano

ENV POSTGRES_USER=db_user
ENV POSTGRES_PASSWORD=db_passw
ENV POSTGRES_DB=odmf

COPY ./db-* /usr/local/bin/
RUN chmod u+x /usr/local/bin/*

