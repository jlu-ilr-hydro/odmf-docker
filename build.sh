#!/bin/bash
TODAY=$(/bin/date -I)
echo "Build odmf:$TODAY"
pushd src
ssh-add
git pull
BRANCH=$(git branch --show-current)
popd
DOCKER_BUILDKIT=1
docker build -t odmf:$TODAY services/odmf/
docker tag odmf:$TODAY odmf:$BRANCH
docker build -t odmf-db:$TODAY services/odmf-db/
docker tag odmf-db:$TODAY odmf-db:$BRANCH
[[ ! -f .env ]] && cp .env-template .env
echo "built odmf[-db]:$TODAY and tagged as odmf[-db]:$BRANCH"
