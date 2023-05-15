#!/bin/bash
# Push description to Docker Hub image
source /bin/set_enviroment.sh

docker run --rm -v $PWD:/workspace \
      -e DOCKERHUB_USERNAME="$DOCKER_REGISTRY_USER" \
      -e DOCKERHUB_PASSWORD="$DOCKER_REGISTRY_PASSWORD" \
      -e DOCKERHUB_REPOSITORY="$CI_PROJECT_PATH" \
      -e README_FILEPATH='/workspace/README.md' \
      peterevans/dockerhub-description:3.4.1