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


echo -e "\n*** Deleting old gatling tests reports ***\n"
function delete_old_reports {

  rm -rf $WORKSPACE/results/
  docker exec $CONTAINER rm -rf /opt/gatling/results/*

}


echo -e "\n*** Running gatling tests in container ***\n"
function run_gatling_test {

  docker exec ${CONTAINER} /opt/gatling/bin/gatling.sh /opt/gatling/bin/gatling.sh -sf /opt/gatling/user-files/simulations/ -s computerdatabase
  .BasicSimulation -rf /opt/gatling/results/

}

echo -e "\n*** Copying gatling reports to workspace ***\n"
function copy_gatling_reports_to_workspace {

  docker cp ${CONTAINER}:/opt/gatling/results $WORKSPACE/

}

echo -e "\n*** Stopping the container ***\n"
function stop_container {

  docker stop ${CONTAINER} 

}



delete_old_reports
run_gatling_test
copy_gatling_reports_to_workspace
stop_container