#!/bin/bash
TODAY=$(/bin/date -I)
echo "Bild odmf:$TODAY"
docker build -t odmf:$TODAY services/odmf/
docker build -t odmf-db:$TODAY services/odmf/
sed -i "s/latest/$TODAY" docker-compose.yml
[[ ! -f .env ]] && cp .env-template .env
