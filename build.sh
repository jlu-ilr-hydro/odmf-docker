#!/bin/bash
TODAY=$(/bin/date -I)
echo "Bild odmf:$TODAY"
DOCKER_BUILDKIT=1
docker build -t odmf:$TODAY services/odmf/
docker build -t odmf-db:$TODAY services/odmf-db/
sed -i "s/latest/$TODAY/g" docker-compose.yml
[[ ! -f .env ]] && cp .env-template .env
