#!/usr/bin/env bash
set -e
cd $(dirname "$0")/..
docker-compose -f compose/docker-compose.lab.yml down -v --remove-orphans
sleep 2
docker-compose -f compose/docker-compose.lab.yml up -d --build