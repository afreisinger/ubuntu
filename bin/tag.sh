#!/bin/bash

#source ./bin/set_enviroment.sh
TAG=$1

function docker_tag_exists() {
    TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_REGISTRY_USER}'", "password": "'${DOCKER_REGISTRY_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
    curl --silent -f --head -lL https://hub.docker.com/v2/repositories/${CI_PROJECT_PATH}/tags/${TAG}/ > /dev/null
}

if docker_tag_exists ${CI_PROJECT_PATH} ${TAG}; then
    echo exist
    echo ${CI_PROJECT_PATH}:${TAG}

else 
    echo not exists
    echo ${CI_PROJECT_PATH}:${TAG}
fi