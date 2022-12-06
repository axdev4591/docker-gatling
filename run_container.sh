#!/bin/bash

function help_text {
    cat <<EOF
    Usage: $0 [ -i|--image IMAGE ] [ -c|--container CONTAINER ] [-h]
        IMAGE         (required) gatling docker image name.
        CONTAINER   (required) gatling container name.
EOF
    exit 1
}

while [ $# -gt 0 ]; do
    arg=$1
    case $arg in
        -h|--help)
            help_text
        ;;
        -i|--image)
            IMAGE="$2"
            shift; shift
        ;;
        -c|--container)
            CONTAINER="$2"
            shift; shift
        ;;
        *)
            echo "ERROR: Unrecognised option: ${arg}"
            help_text
            exit 1
        ;;
    esac
done


function check_container_exist {

   echo -e "\n *** Deleting old unused containers"

   docker rm $(docker ps -a | grep 'docker-gatling-container' | awk '{print $3}')

  echo -e "\n*** Checking if the container exists ***\n"

    if docker ps -a | grep ${CONTAINER}
    then
        echo -e "\n*** Container already exists ***\n"
        docker start ${CONTAINER}
    else
        echo -e "\n*** Running the container ***\n"
        start_container
    fi
}

function start_container {
  docker run -t --rm -v $WORKSPACE/conf:/opt/gatling/conf \
  -v $WORKSPACE/user-files:/opt/gatling/user-files \
  -v $WORKSPACE/results:/opt/gatling/results \
  --name $CONTAINER $IMAGE
}

check_container_exist


