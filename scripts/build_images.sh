#!/usr/bin/env bash
set -e
cd $(dirname "$0")/..
# build kali
docker build -t lab/kali:1.0 -f dockerfiles/Dockerfile.kali dockerfiles
# build suricata
docker build -t lab/suricata:1.0 -f dockerfiles/Dockerfile.suricata dockerfiles