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

function check_image_exist {
    echo -e "\n*** Checking if docker image exists... ***\n"

    if docker images | grep -w ${IMAGE}
    then
    echo -e "\n*** Image already exists. We can just run container: ${CONTAINER}... ***\n"

    else
    build_image
    fi
}

function build_image {

    echo -e "\n*** Building the image ***\n"
    docker build -t ${IMAGE} .
    echo -e "\n*** Finished building the image ***\n"

}

check_image_exist