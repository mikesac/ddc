#!/usr/bin/env bash

docker network create -d overlay traefiknet

docker service create \
    --name traefik \
    --network traefiknet \
    --constraint=node.role==manager \
    --publish 80:80 --publish 8080:8080 \
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    dtr.facilitylive.int/infrastructure/proxy:latest \
    -c /config/traefik.toml


docker service create \
    --name caturday \
    --label traefik.port=80 \
    --replicas 10 \
    --network traefiknet \
    --label "traefik.backend=caturday" \
    --label "traefik.frontend.rule=Host:caturday" \
    fntlnz/caturday
