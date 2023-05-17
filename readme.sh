#!/bin/bash
# Push description to Docker Hub image

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BIN_DIR="${SCRIPT_DIR}/bin"

source $BIN_DIR/set_enviroment.sh

docker run --rm -v $PWD:/workspace \
      -e DOCKERHUB_USERNAME="$DOCKER_REGISTRY_USER" \
      -e DOCKERHUB_PASSWORD="$DOCKER_REGISTRY_PASSWORD" \
      -e DOCKERHUB_REPOSITORY="$CI_PROJECT_PATH" \
      -e README_FILEPATH='/workspace/README.md' \
      peterevans/dockerhub-description:3.4.1