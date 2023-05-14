#!/bin/bash

export CI_REGISTRY=registry.gitlab.com    #The address of the GitLab Container Registry. Only available if the Container Registry is enabled for the project. This variable includes a :port value if one is specified in the registry configuration.
export CI_PROJECT_NAMESPACE=afreisinger   #The project namespace (username or group name) of the job.
export CI_PROJECT_NAME=ubuntu-sshd      #The name of the directory for the project. For example if the project URL is gitlab.example.com/group-name/project-1, CI_PROJECT_NAME is project-1.
export CI_PROJECT_PATH=$CI_PROJECT_NAMESPACE/$CI_PROJECT_NAME  #The project namespace with the project name included.
export CI_REGISTRY_IMAGE=$CI_REGISTRY/$CI_PROJECT_PATH  #The address of the project’s Container Registry. Only available if the Container Registry is enabled for the project.
export DOCKER_REGISTRY=docker.io
#export DEPLOY_ENV=development # is either "production"or "development"
#export CI_DEFAULT_BRANCH=main
#export CI_COMMIT_REF_SLUG=main
#export CI_BUILD_REF=123456
export CI_PIPELINE_ID=$(shuf -i 699999999-999999999 -n 1)
#export $(xargs < .env) #It doesn't handle cases where the values have spaces
set -a; . ./.env; set +a