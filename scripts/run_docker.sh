#!/usr/bin/env bash

CONTAINER_NAME="brian87/ml-api"
VERSION=latest
CONTAINER_PORT=80
HOST_PORT=80

# Run app
docker run -t --rm -p ${HOST_PORT}:${CONTAINER_PORT} ${CONTAINER_NAME}:${VERSION}