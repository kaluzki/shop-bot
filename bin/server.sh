#!/usr/bin/env bash

if [[ $# -ne 0 ]]; then
    docker-compose $@
    exit 1
fi

docker network inspect traefik > /dev/null 2>&1 || docker network create traefik > /dev/null 2>&1

docker start traefik 2>/dev/null || docker run -tid --name traefik --net=traefik \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 80:80 -p 443:443 -p 8080:8080 \
    traefik:1.5 \
    --api \
    --logLevel=error \
    --entrypoints='Name:http Address::80' \
    --entrypoints='Name:https Address::443 TLS' \
    --defaultentrypoints=http,https \
    --docker \
    --docker.exposedbydefault=false \
    2>/dev/null

docker-compose up -d

docker-compose exec -u $UID app bash
