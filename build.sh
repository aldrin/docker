#!/usr/bin/env bash

# Copyright 2017 Aldrin J D'Souza.
# Licensed under the MIT License <https://opensource.org/licenses/MIT>

# Build images and optionally push them
set -ex

# A list of images we manage (i.e. all sub-directories with Dockerfiles in them)
declare -r -a images=(`find . -maxdepth 2 -name Dockerfile -exec dirname {} \; | xargs -n 1 basename`)

# The repository name
declare -r repository=ajdz

# The Docker registry user name
declare -r user=${DOCKER_USERNAME:-ajdz}

# The Git tag (used to signal releases)
declare -r tag=${TRAVIS_TAG:-latest-all}

# The version (everything upto the -, e.g. 1.0.0)
declare -r version=${tag%-*}

# The image (everything after the -, e.g. rust)
declare -r image=${tag##*-}

# Build an image in the given directory.
# $1 - The image directory (e.g. `rust`)
# $2 - The build mode (`deploy` for pushes)
function build() {
    
    local -r dir="$1"; shift
    local -r mode="$1"; shift
    local -r docker_image="$repository/$dir:$version"
    
    docker build --rm -t $docker_image $dir

    if [[ $CI == "true" && $mode == "deploy" ]]; then
        docker login -u $user --password-stdin <<< $DOCKER_PASSWORD
        docker push $docker_image
    fi
}

# The main function
function main() {
    
    local -r mode=${1:-build}

    case $image in
        all) # Build all images
            for i in "${images[@]}"; do
                build $i $mode;
            done
            ;;
        *) # Build a specific image
            build $image $mode
            ;;
    esac
}

# Begin
main $@
