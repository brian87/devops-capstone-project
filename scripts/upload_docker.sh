#!/usr/bin/env bash

# Assumes that an image is built via `build_docker.sh`
DOCKER_HUB_ID="brian87"
DOCKER_REPOSITORY="hello-app"
VERSION="0.0.1"

# Step 1:
# dockerpath=<DockerID/path>
DOCKER_PATH=${DOCKER_HUB_ID}/${DOCKER_REPOSITORY}

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login -u ${DOCKER_HUB_ID}
docker tag ${DOCKER_REPOSITORY}:${VERSION} ${DOCKER_PATH}:${VERSION}

# Step 3:
# Push image to a docker repository
docker push ${DOCKER_PATH}:${VERSION}