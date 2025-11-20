# The docker file for ODMF

# Using the official python:3.10 package, to play it safe
# Alpine and slim do not offer support for git or manylinux binaries
# See https://pythonspeed.com/articles/alpine-docker-python/

# volumes:
#   - ./app/:/srv/odmf

FROM python:3.13 AS base
LABEL version="2025.10.20" org.opencontainers.image.authors="Philipp Kraft"

RUN  apt-get update && apt-get install -y --no-install-recommends apt-utils && \
     apt-get install -y gzip nano git

ENV PIP_ROOT_USER_ACTION=ignore
ARG PIP_ROOT_USER_ACTION=ignore
ARG PIP=/usr/local/bin/pip3

ENV ODMF_URL=$ODMF_URL
ENV ODMF_USER=$ODMF_USER
ENV ODMF_PASSWD=$ODMF_PASSWD

RUN python3 -m pip install --upgrade pip setuptools wheel
WORKDIR /app
RUN --mount=type=cache,target=/root/.cache pip3 install odmfclient --upgrade


