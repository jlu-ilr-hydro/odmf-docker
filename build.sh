#!/bin/bash
TODAY=$(/bin/date -I)
echo "Build odmf:$TODAY"
pushd src
[ -z "$1"] || git checkout "$1"
git pull
BRANCH=$(git branch --show-current)
echo "odmf:$BRANCH"
popd
DOCKER_BUILDKIT=1

docker pull python:latest
docker build -t odmf:$TODAY services/odmf/
docker tag odmf:$TODAY odmf:$BRANCH

docker build -t odmf-db:$TODAY services/odmf-db/
docker tag odmf-db:$TODAY odmf-db:$BRANCH

docker build -t odmf-client:latest services/odmf-client

[[ ! -f .env ]] && cp .env-template .env
echo "built odmf[-db]:$TODAY and tagged as odmf[-db]:$BRANCH"
